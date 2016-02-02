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

@end
