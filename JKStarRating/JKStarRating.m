//
//  JKStarRating.m
//  JK_Assistant
//
//  Created by  on 2017/9/28.
//  Copyright © 2017年 . All rights reserved.
//

#import "JKStarRating.h"

@interface JKStarRating ()
@property (nonatomic) CGColorRef backCGColor;
@end

CGFloat ED_DEFAULT_HALFSTAR_THRESHOLD = 0.6;
@implementation JKStarRating

#pragma mark Init & dealloc
- (void)setDefaultProperties
{
    self.maxRating = 5.0;
    self.rating = 0.0;
    self.horizontalMargin = 0;
    self.displayMode = JKStarRatingDisplayFull;
    self.halfStarThreshold = ED_DEFAULT_HALFSTAR_THRESHOLD;
    self.backgroundColor = [UIColor clearColor];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaultProperties];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultProperties];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGRect bounds = self.bounds;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // Fill background color
    CGContextSetFillColorWithColor(ctx, self.backCGColor);
    CGContextFillRect(ctx, bounds);
    // Draw rating Images
    CGSize starSize = self.selectImage.size;
    for(NSInteger i = 0; i < self.maxRating; i++) {
        [self.normalImage drawAtPoint:[self pointOfStarAtPosition:i highlighted:YES]];
        
        if (i < self.rating) {
            CGContextSaveGState(ctx);
            
            if (i < self.rating &&  self.rating < i + 1) {
                CGPoint starPoint = [self pointOfStarAtPosition:i highlighted:NO];
                float difference = self.rating - i;
                CGRect rectClip;
                rectClip.origin = starPoint;
                rectClip.size = starSize;
                if (self.displayMode == JKStarRatingDisplayHalf && difference < self.halfStarThreshold ) {    // Draw half star image
                    rectClip.size.width /= 2.0;
                }
                else if  (self.displayMode == JKStarRatingDisplayAccurate) {
                    rectClip.size.width *= difference;
                }
                else {
                    rectClip.size.width = 0;
                }
                if (rectClip.size.width > 0) {
                    CGContextClipToRect( ctx, rectClip);
                }
            }
            
            [self.selectImage drawAtPoint:[self pointOfStarAtPosition:i highlighted:YES]];
            CGContextRestoreGState(ctx);
        }
    }
}

#pragma mark Drawing
- (CGPoint)pointOfStarAtPosition:(NSInteger)position highlighted:(BOOL)hightlighted
{
    CGSize size = hightlighted ? self.selectImage.size : self.normalImage.size;
    NSInteger starsSpace = self.bounds.size.width - 2 * self.horizontalMargin;
    
    NSInteger interSpace = 0;
    interSpace = self.maxRating - 1 > 0 ? (starsSpace - (self.maxRating) * size.width) / (self.maxRating - 1) : 0;
    if(interSpace < 0)
        interSpace = 0;
    CGFloat x = self.horizontalMargin + size.width * position;
    if( position > 0 )
        x += interSpace * position;
    CGFloat y = (self.bounds.size.height - size.height) / 2.0;
    return CGPointMake(x  ,y);
}
#pragma mark Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.backCGColor = backgroundColor.CGColor;
}
- (void)setReturnBlock:(JKStarRatingReturnBlock)returnBlock
{
    _returnBlock = [returnBlock copy];
    _delegate = nil;
}
- (void)setDelegate:(id<JKStarRatingDelegate>)delegate
{
    _delegate = delegate;
    _returnBlock = nil;
}
- (void)setRating:(float)rating
{
    _rating = rating;
    [self setNeedsDisplay];
}
- (void)setDisplayMode:(JKStarRatingDisplayMode)displayMode
{
    _displayMode = displayMode;
    [self setNeedsDisplay];
}


#pragma mark touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.editable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating = [self starsForPoint:touchLocation];
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.editable) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    self.rating =[self starsForPoint:touchLocation];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.editable) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(starsSelectionChanged:rating:)]) {
        [self.delegate starsSelectionChanged:self rating:self.rating];
    }
    if (self.returnBlock) {
        self.returnBlock(self.rating);
    }
}
#pragma mark Mouse/Touch Interaction
- (CGFloat)starsForPoint:(CGPoint)point
{
    float stars=0;
    for (NSInteger i = 0; i < self.maxRating; i++) {
        CGPoint p = [self pointOfStarAtPosition:i highlighted:NO];
        
        if (point.x > p.x) {
            float increment = 1.0;
            
            if (self.displayMode == JKStarRatingDisplayHalf) {
                float difference = (point.x - p.x) / self.normalImage.size.width;
                
                if (difference < self.halfStarThreshold) {
                    increment = 0.5;
                }
            }
            stars += increment;
        }
    }
    return stars;
}

@end
