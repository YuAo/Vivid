//
//  YUCIFlashTransition.h
//  Pods
//
//  Created by YuAo on 2/4/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCIFlashTransition : CIFilter

@property (nonatomic,strong) CIImage *inputImage;
@property (nonatomic,strong) CIImage *inputTargetImage;

@property (nonatomic,copy) NSNumber *inputFlashPhase;
@property (nonatomic,copy) NSNumber *inputFlashIntensity;
@property (nonatomic,copy) NSNumber *inputFlashZoom;

@property (nonatomic,copy) CIVector *inputExtent;

@property (nonatomic,copy) NSNumber *inputTime; /* 0 to 1 */

@end
