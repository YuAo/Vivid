//
//  YUCIStarNestGenerator.h
//  Pods
//
//  Created by YuAo on 2/4/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCIStarfieldGenerator : CIFilter

@property (nonatomic,copy) CIVector *inputExtent;

@property (nonatomic,copy) NSNumber *inputTime;

@property (nonatomic,copy) CIVector *inputRotation;

@end
