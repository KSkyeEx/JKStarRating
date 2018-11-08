//
//  JKStarRating.h
//  JK_Assistant
//
//  Created by  on 2017/9/28.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKStarRating;

typedef NS_ENUM(NSUInteger, JKStarRatingDisplayMode) {
    JKStarRatingDisplayFull = 0,
    JKStarRatingDisplayHalf,
    JKStarRatingDisplayAccurate
};

typedef void(^JKStarRatingReturnBlock)(float rating);

@protocol JKStarRatingDelegate <NSObject>
@optional
/**
 选中了几颗星

 @param control 星星控件
@param rating 选中了几颗星
 */
- (void)starsSelectionChanged:(JKStarRating *)control rating:(float)rating;
@end

@interface JKStarRating : UIControl
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
@property (nonatomic, assign) JKStarRatingDisplayMode displayMode;
@property (nonatomic, assign) float halfStarThreshold;
/**
 代理
 */
@property (nonatomic, weak) id<JKStarRatingDelegate> delegate;
/**
 block
 */
@property (nonatomic, copy) JKStarRatingReturnBlock returnBlock;
@end
