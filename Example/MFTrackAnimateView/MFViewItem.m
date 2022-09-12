//
// Created by Neal on 2022/9/12.
// Copyright (c) 2022 NealWills. All rights reserved.
//

#import "MFViewItem.h"

@interface MFViewItem ()

@property (nonatomic, strong) UIView *item;

@end

@implementation MFViewItem {

}

- (void)destroyItem {

    if (_item) {
        [_item removeFromSuperview];
    }
}

- (void)configureSubviews {
//    self.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.2 alpha:1];
    self.item = [[UIView alloc] initWithFrame:self.bounds];
    self.item.layer.cornerRadius = self.bounds.size.height / 2.0;
    self.item.clipsToBounds = YES;
    self.item.backgroundColor = [UIColor colorWithRed:0.5 green:0.8 blue:0.2 alpha:1];
    [self addSubview:self.item];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.item.layer.cornerRadius = frame.size.height / 2.0;
}

@end