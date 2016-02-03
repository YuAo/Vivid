//
//  YUCIBilateralFilter.h
//  Pods
//
//  Created by YuAo on 2/2/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCIBilateralFilter : CIFilter

@property (nonatomic,strong) CIImage *inputImage;

@property (nonatomic,copy) NSNumber *inputRadius; //default 10
@property (nonatomic,copy) NSNumber *inputDistanceNormalizationFactor; //default 6.0
@property (nonatomic,copy) NSNumber *inputTexelSpacingMultiplier; //default 1.0

@end
