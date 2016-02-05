//
//  YUCIBubblesGenerator.h
//  Pods
//
//  Created by YuAo on 2/5/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCIBubblesGenerator : CIFilter

@property (nonatomic,copy) CIVector *inputExtent;

@property (nonatomic,copy) NSNumber *inputTime;

@end
