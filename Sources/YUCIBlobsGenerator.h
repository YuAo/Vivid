//
//  YUCIBlobsGenerator.h
//  Pods
//
//  Created by YuAo on 2/6/16.
//
//

#import <CoreImage/CoreImage.h>

@interface YUCIBlobsGenerator : CIFilter

@property (nonatomic,copy) CIVector *inputExtent;

@property (nonatomic,copy) NSNumber *inputTime;


@end
