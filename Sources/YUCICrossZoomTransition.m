//
//  YUCICrossZoomTransition.m
//  Pods
//
//  Created by YuAo on 2/4/16.
//
//

#import "YUCICrossZoomTransition.h"

@implementation YUCICrossZoomTransition

+ (CIKernel *)filterKernel {
    static CIKernel *kernel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *kernelString = [[NSString alloc] initWithContentsOfURL:[[NSBundle bundleForClass:self] URLForResource:NSStringFromClass([YUCICrossZoomTransition class]) withExtension:@"cikernel"] encoding:NSUTF8StringEncoding error:nil];
        kernel = [CIKernel kernelWithString:kernelString];
    });
    return kernel;
}

- (NSNumber *)inputStrength {
    if (!_inputStrength) {
        _inputStrength = @(0.3);
    }
    return _inputStrength;
}

- (NSNumber *)inputTime {
    if (!_inputTime) {
        _inputTime = @(0.0);
    }
    return _inputTime;
}

- (CIImage *)outputImage {
    CIVector *defaultInputExtent = [CIVector vectorWithCGRect:CGRectUnion(self.inputImage.extent, self.outputImage.extent)];
    self.inputExtent = [CIVector vectorWithCGRect:self.inputImage.extent];
    return [[YUCICrossZoomTransition filterKernel] applyWithExtent:self.inputImage.extent
                                                       roiCallback:^CGRect(int index, CGRect destRect) {
                                                           return destRect;
                                                       }
                                                         arguments:@[self.inputImage,self.inputTargetImage,self.inputStrength,self.inputExtent?:defaultInputExtent,self.inputTime]];
}

@end
