//
//  YUCICrossZoomTransition.h
//  Pods
//
//  Created by YuAo on 2/4/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCICrossZoomTransition : CIFilter

@property (nonatomic,strong) CIImage *inputImage;
@property (nonatomic,strong) CIImage *inputTargetImage;

@property (nonatomic,copy) CIVector *inputExtent;

@property (nonatomic,copy) NSNumber *inputStrength;

@property (nonatomic,copy) NSNumber *inputTime; /* 0 to 1 */

@end
