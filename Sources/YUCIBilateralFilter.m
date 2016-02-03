//
//  YUCIBilateralFilter.m
//  Pods
//
//  Created by YuAo on 2/2/16.
//
//

#import "YUCIBilateralFilter.h"

@implementation YUCIBilateralFilter

+ (CIKernel *)filterKernelForRadius:(NSInteger)radius {
    if (radius <= 0) {
        radius = 1;
    }
    if (radius % 2 == 0) {
        radius = radius + 1;
    }
    static NSDictionary *kernels;
    if (kernels[@(radius)]) {
        return kernels[@(radius)];
    } else {
        double d = (radius/4.0);
        NSString *setupString = @"";
        for (NSInteger i = 0; i < (radius + 1)/2; i++) {
            double factor = 1.0/sqrt(2 * M_PI * d * d) * pow(M_E, (- i * i) / (2 * d * d));
            setupString = [setupString stringByAppendingFormat:@"gaussianWeightFactors[%@] = %@; \n",@(i),@(factor)];
        }
        NSString *kernelString = [[NSString alloc] initWithContentsOfURL:[[NSBundle bundleForClass:self] URLForResource:NSStringFromClass([YUCIBilateralFilter class]) withExtension:@"cikernel"] encoding:NSUTF8StringEncoding error:nil];
        kernelString = [kernelString stringByReplacingOccurrencesOfString:@"MACRO_GAUSSIAN_SAMPLES" withString:@(radius).stringValue];
        kernelString = [kernelString stringByReplacingOccurrencesOfString:@"MACRO_SETUP_GAUSSIAN_WEIGHT_FACTORS" withString:setupString];
        CIKernel *kernel = [CIKernel kernelWithString:kernelString];
        NSMutableDictionary *newKernels = [NSMutableDictionary dictionaryWithDictionary:kernels];
        [newKernels setObject:kernel forKey:@(radius)];
        kernels = newKernels.copy;
        return kernel;
    }
}

- (CIImage *)outputImage {
    CIImage *horizontalPassResult = [[YUCIBilateralFilter filterKernelForRadius:15] applyWithExtent:self.inputImage.extent
                                                                            roiCallback:^CGRect(int index, CGRect destRect) {
                                                                                return destRect;
                                                                            } arguments:@[
                                                                                          self.inputImage,
                                                                                          [CIVector vectorWithX:1 Y:0],
                                                                                          @(4.0)]];
    CIImage *verticalPassResult = [[YUCIBilateralFilter filterKernelForRadius:15] applyWithExtent:horizontalPassResult.extent
                                                                            roiCallback:^CGRect(int index, CGRect destRect) {
                                                                                return destRect;
                                                                            } arguments:@[horizontalPassResult,
                                                                                          [CIVector vectorWithX:0 Y:1],
                                                                                          @(4.0)]];
    return verticalPassResult;
}

@end
