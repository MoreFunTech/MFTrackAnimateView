//
// Created by Neal on 2022/9/13.
//

#import "MFTrackAnimateViewPoint.h"


@implementation MFTrackAnimateViewPoint {

}

+ (MFTrackAnimateViewPoint *(^)(CGFloat x, CGFloat y))pointMake {
    return ^(CGFloat x, CGFloat y) {
        MFTrackAnimateViewPoint *point = [[MFTrackAnimateViewPoint alloc] init];
        point.x = x;
        point.y = y;
        return point;
    };
}

@end