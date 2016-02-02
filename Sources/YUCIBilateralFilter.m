//
//  YUCIBilateralFilter.m
//  Pods
//
//  Created by YuAo on 2/2/16.
//
//

#import "YUCIBilateralFilter.h"

@implementation YUCIBilateralFilter

+ (CIKernel *)filterKernel {
    static CIKernel *kernel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *kernelString = [[NSString alloc] initWithContentsOfURL:[[NSBundle bundleForClass:self] URLForResource:NSStringFromClass([YUCIBilateralFilter class]) withExtension:@"cikernel"] encoding:NSUTF8StringEncoding error:nil];
        kernel = [CIKernel kernelWithString:kernelString];
    });
    return kernel;
}

- (CIImage *)outputImage {
    CIImage *horizontalPassResult = [[YUCIBilateralFilter filterKernel] applyWithExtent:self.inputImage.extent
                                                                            roiCallback:^CGRect(int index, CGRect destRect) {
                                                                                return destRect;
                                                                            } arguments:@[self.inputImage,[CIVector vectorWithX:4 Y:0],@(8.0)]];
    CIImage *verticalPassResult = [[YUCIBilateralFilter filterKernel] applyWithExtent:horizontalPassResult.extent
                                                                            roiCallback:^CGRect(int index, CGRect destRect) {
                                                                                return destRect;
                                                                            } arguments:@[horizontalPassResult,[CIVector vectorWithX:0 Y:4],@(8.0)]];
    return verticalPassResult;
}

@end
