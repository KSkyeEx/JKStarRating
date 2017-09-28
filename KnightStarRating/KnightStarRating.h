//
//  KnightStarRating.h
//  Knight_Assistant
//
//  Created by shanyou on 2017/9/28.
//  Copyright © 2017年 闪游网络. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KnightStarRating;

typedef NS_ENUM(NSUInteger, KnightStarRatingDisplayMode) {
    KnightStarRatingDisplayFull = 0,
    KnightStarRatingDisplayHalf,
    KnightStarRatingDisplayAccurate
};

typedef void(^KnightStarRatingReturnBlock)(float rating);

@protocol KnightStarRatingDelegate <NSObject>
@optional
/**
 选中了几颗星

 @param control 星星控件
@param rating 选中了几颗星
 */
- (void)starsSelectionChanged:(KnightStarRating *)control rating:(float)rating;
@end

@interface KnightStarRating : UIControl
/**
 选中的星星
 */
@property (nonatomic, strong) UIImage *selectImage;
/**
 未选中的星星
 */
@property (nonatomic, strong) UIImage *normalImage;
/**
 最大的评分数量
 */
@property (nonatomic, assign) NSInteger maxRating;
/**
 评分数
 */
@property (nonatomic, assign) float rating;
/**
 水平左右的间距离，默认为0
 */
@property (nonatomic, assign) CGFloat horizontalMargin;
/**
 是否允许编辑
 */
@property (nonatomic, assign) BOOL editable;
/**
 显示的模式
 */
@property (nonatomic, assign) KnightStarRatingDisplayMode displayMode;
@property (nonatomic, assign) float halfStarThreshold;
/**
 代理
 */
@property (nonatomic, weak) id<KnightStarRatingDelegate> delegate;
/**
 block
 */
@property (nonatomic, copy) KnightStarRatingReturnBlock returnBlock;
@end
