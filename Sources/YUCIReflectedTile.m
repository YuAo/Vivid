//
//  YUCIReflectTile.m
//  Pods
//
//  Created by YuAo on 2/16/16.
//
//

#import "YUCIReflectedTile.h"
#import "YUCIFilterConstructor.h"

@implementation YUCIReflectedTile

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if ([CIFilter respondsToSelector:@selector(registerFilterName:constructor:classAttributes:)]) {
                [CIFilter registerFilterName:NSStringFromClass([YUCIReflectedTile class])
                                 constructor:[YUCIFilterConstructor constructor]
                             classAttributes:@{kCIAttributeFilterCategories: @[kCICategoryStillImage,kCICategoryVideo,kCICategoryTileEffect],
                                               kCIAttributeFilterDisplayName: @"Reflected Tile"}];
            }
        }
    });
}

+ (CIWarpKernel *)filterKernel {
    static CIWarpKernel *kernel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *kernelString = [[NSString alloc] initWithContentsOfURL:[[NSBundle bundleForClass:self] URLForResource:NSStringFromClass([YUCIReflectedTile class]) withExtension:@"cikernel"] encoding:NSUTF8StringEncoding error:nil];
        kernel = [CIWarpKernel kernelWithString:kernelString];
    });
    return kernel;
}

- (NSNumber *)inputMode {
    if (!_inputMode) {
        _inputMode = @(YUCIReflectedTileModeReflectWithoutBorder);
    }
    return _inputMode;
}

- (CIImage *)outputImage {
    CGRect inputExtent = self.inputImage.extent;
    return [[YUCIReflectedTile filterKernel] applyWithExtent:CGRectInfinite
                                                 roiCallback:^CGRect(int index, CGRect destRect) {
                                                     CGPoint coord = destRect.origin;
                                                     if (CGRectContainsRect(inputExtent, destRect)) {
                                                         return destRect;
                                                     } else {
                                                         float w = inputExtent.size.width - (self.inputMode.integerValue == YUCIReflectedTileModeReflectWithoutBorder ? 1.0: 0.0);
                                                         float h = inputExtent.size.height - (self.inputMode.integerValue == YUCIReflectedTileModeReflectWithoutBorder ? 1.0: 0.0);
                                                         
                                                         float x = coord.x - inputExtent.origin.x - inputExtent.size.width;
                                                         NSInteger nx = x/w;
                                                         float dx = x - nx * w;
                                                         
                                                         float y = coord.y - inputExtent.origin.y - inputExtent.size.height;
                                                         NSInteger ny = y/h;
                                                         float dy = y - ny * h;
                                                         
                                                         if (nx % 2 == 1) {
                                                             coord.x = inputExtent.origin.x + inputExtent.size.width - (w - dx);
                                                         } else {
                                                             coord.x = inputExtent.origin.x + (w - dx) - destRect.size.width;
                                                         }
                                                         
                                                         if (ny % 2 == 1) {
                                                             coord.y = inputExtent.origin.y + inputExtent.size.height - (h - dy);
                                                         } else {
                                                             coord.y = inputExtent.origin.y + (h - dy) - destRect.size.height;
                                                         }
                                                         
                                                         return CGRectMake(coord.x, coord.y, destRect.size.width, destRect.size.height);
                                                     }
                                                 }
                                                  inputImage:self.inputImage
                                                   arguments:@[self.inputMode,[CIVector vectorWithCGRect:self.inputImage.extent]]];
}

@end
