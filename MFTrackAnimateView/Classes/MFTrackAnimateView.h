//
//  MFTrackAnimateView.h
//  Expecta
//
//  Created by Administer on 2022/8/5.
//

#import <UIKit/UIKit.h>


#import "MFTrackAnimateViewHeader.h"

NS_ASSUME_NONNULL_BEGIN


@interface MFTrackAnimateView : UIView

/**
 * 旋转展开轨道动画
 * @param frame 视图尺寸
 * @param configureModel 配置文件
 * @param dataSource 数据源代理
 * @return
 */
+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                   configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel
        dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource;

/**
 * 旋转展开轨道动画
 * @param frame 视图尺寸
 * @param configureModel 配置文件
 * @param dataSource 数据源代理
 * @param selectActionBlock 点击事件回调
 * @return
 */
+ (MFTrackAnimateViewRotateExpandView *)rotateExpandViewWithFrame:(CGRect)frame
                                                   configureModel:(MFTrackAnimateViewRotateExpandViewConfigureModel *)configureModel
                                                       dataSource:(id <MFTrackAnimateViewRotateExpandViewDataSource>)dataSource
                                                selectActionBlock:(void(^)(NSUInteger selectIndex))selectActionBlock;

@end

NS_ASSUME_NONNULL_END
