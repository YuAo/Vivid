//
//  YUCIBubblesGenerator.m
//  Pods
//
//  Created by YuAo on 2/5/16.
//
//

#import "YUCIBubblesGenerator.h"
#import "YUCIFilterConstructor.h"

@implementation YUCIBubblesGenerator

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if ([CIFilter respondsToSelector:@selector(registerFilterName:constructor:classAttributes:)]) {
                [CIFilter registerFilterName:NSStringFromClass([YUCIBubblesGenerator class])
                                 constructor:[YUCIFilterConstructor constructor]
                             classAttributes:@{kCIAttributeFilterCategories: @[kCICategoryStillImage,kCICategoryVideo,kCICategoryGenerator],
                                               kCIAttributeFilterDisplayName: @"Bubbles Generator"}];
            }
        }
    });
}

+ (CIColorKernel *)filterKernel {
    static CIColorKernel *kernel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *kernelString = [[NSString alloc] initWithContentsOfURL:[[NSBundle bundleForClass:self] URLForResource:NSStringFromClass([YUCIBubblesGenerator class]) withExtension:@"cikernel"] encoding:NSUTF8StringEncoding error:nil];
        kernel = [CIColorKernel kernelWithString:kernelString];
    });
    return kernel;
}

- (CIVector *)inputExtent {
    if (!_inputExtent) {
        _inputExtent = [CIVector vectorWithCGRect:CGRectMake(0, 0, 640, 480)];
    }
    return _inputExtent;
}

- (NSNumber *)inputTime {
    if (!_inputTime) {
        _inputTime = @(0);
    }
    return _inputTime;
}

- (CIImage *)outputImage {
    return [[YUCIBubblesGenerator filterKernel] applyWithExtent:self.inputExtent.CGRectValue
                                                      arguments:@[self.inputExtent,self.inputTime]];
}

@end
