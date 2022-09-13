//
//  MFTrackAnimateView.m
//  Expecta
//
//  Created by Administer on 2022/8/5.
//

#import "MFTrackAnimateView.h"

@implementation MFTrackAnimateView

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel dataSource:(id)dataSource {
    return [self rotateExpandViewWithFrame:frame configureModel:configureModel dataSource:dataSource selectActionBlock:^(NSUInteger selectIndex) { }];
}

+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel dataSource:(id)dataSource selectActionBlock:(void (^)(NSUInteger))selectActionBlock {
    MFTrackAnimateViewRotateExpandView *view = [[MFTrackAnimateViewRotateExpandView alloc] initWithFrame:frame];
    view.configureModel = configureModel;
    view.dataSource = dataSource;
    view.selectActionBlock = selectActionBlock;
    return view;
}


@end
