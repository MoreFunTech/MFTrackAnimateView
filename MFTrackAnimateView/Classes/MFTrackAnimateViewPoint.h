//
// Created by Neal on 2022/9/13.
//

#import <Foundation/Foundation.h>


@interface MFTrackAnimateViewPoint : NSObject

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

+ (MFTrackAnimateViewPoint *(^)(CGFloat x, CGFloat y))pointMake;

@end