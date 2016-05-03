//
//  UIButtonLoad.m
//  WhdeButtonDemo
//
//  Created by whde on 16/4/29.
//  Copyright © 2016年 whde. All rights reserved.
//

#import "UIButtonLoad.h"
@implementation UIButtonLoad {
    Action _action;
    
    CGRect _frame;
    CGPoint _center;
    CGFloat _cornerRadius;
    BOOL _masksToBounds;
    UIImage *_image;
    UIImage *_backgroudImage;
    
    CAShapeLayer *_LoadingShapeLayer;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents NS_DEPRECATED_IOS(2_0, 3_0, "在 UIButtonLoad 使用 addAction: 方法替代") {
    [super addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    _image = self.currentImage;
}
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [super setBackgroundImage:image forState:state];
    _backgroudImage = self.currentBackgroundImage;
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _frame = frame;
    _center = self.center;
}
- (void)setCenter:(CGPoint)center {
    [super setCenter:center];
    _center = self.center;
}


- (void)addAction:(Action)action {
    if (action) {
        _action = [action copy];
    } else {
        _action = nil;
    }
    [super addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(UIButtonLoad *)btn {
    if (self.titleLabel.alpha!=1) {
        return;
    }
    self.titleLabel.alpha=0;
    if (_action) {
        _action(btn);
    }
    _center = self.center;
    _frame = self.frame;
    _cornerRadius = self.layer.cornerRadius;
    _masksToBounds = self.layer.masksToBounds;
    _image = self.currentImage;
    _backgroudImage = self.currentBackgroundImage;
    [self startAnimation];
}

- (void)startAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        super.layer.masksToBounds = YES;
        CGFloat minSide = _frame.size.height>_frame.size.width?_frame.size.width:_frame.size.height;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect rect = self.frame;
            if (_frame.size.height>_frame.size.width) {
                rect.origin.y = rect.origin.y-5;
                rect.size.height = rect.size.height+10;
            } else {
                rect.origin.x = rect.origin.x-5;
                rect.size.width = rect.size.width+10;
            }
            super.frame = rect;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [super setBackgroundImage:nil forState:UIControlStateNormal];
                [super setImage:nil forState:UIControlStateNormal];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                    animation.duration = 0.2;
                    animation.removedOnCompletion = YES;
                    [super.layer setCornerRadius:minSide/2];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        CGRect rect = self.frame;
                        rect.size.width = minSide;
                        rect.size.height = minSide;
                        super.frame = rect;
                        super.center = _center;
                        [self loading];
                    }];
                }];
            }];
        }];
    });
}

- (void)loading {
    CGFloat minSide = _frame.size.height>_frame.size.width?_frame.size.width:_frame.size.height;
    CGFloat inset = minSide/2;
    CGFloat width = minSide-inset;
    _LoadingShapeLayer = [[CAShapeLayer alloc] init];
    _LoadingShapeLayer.fillColor = UIColor.clearColor.CGColor;
    _LoadingShapeLayer.lineWidth = 4;
    _LoadingShapeLayer.strokeColor =  UIColor.yellowColor.CGColor;
    _LoadingShapeLayer.strokeStart = 0.0;
    _LoadingShapeLayer.strokeEnd = 1;
    _LoadingShapeLayer.frame = CGRectMake(inset/2, inset/2, width, width);
    _LoadingShapeLayer.backgroundColor = UIColor.clearColor.CGColor;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:CGPointMake(width/2, width/2) radius:width/2 startAngle:2*M_PI endAngle:2*M_PI+2*M_PI clockwise:YES];
    _LoadingShapeLayer.path = path.CGPath;
    [self upadateLayer:_LoadingShapeLayer];
    [super.layer addSublayer:_LoadingShapeLayer];
}
- (void)upadateLayer:(CAShapeLayer *)layer {
    CABasicAnimation *animation = [[CABasicAnimation alloc] init];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    animation.fromValue = @(0);
    animation.toValue = @(2*M_PI);
    animation.repeatCount = LINK_MAX;
    [layer addAnimation:animation forKey:@"transform.rotation"];
    
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    CABasicAnimation *headAnimation = [[CABasicAnimation alloc] init];
    headAnimation.keyPath = @"strokeStart";
    headAnimation.duration = 1;
    headAnimation.fromValue = @(0);
    headAnimation.toValue = @(0.25);
    headAnimation.timingFunction = timingFunction;
    
    CABasicAnimation *tailAnimation = [[CABasicAnimation alloc] init];
    tailAnimation.keyPath = @"strokeEnd";
    tailAnimation.duration = 1;
    tailAnimation.fromValue = @(0);
    tailAnimation.toValue = @(1);
    tailAnimation.timingFunction = timingFunction;
    
    CABasicAnimation *endHeadAnimation = [[CABasicAnimation alloc] init];
    endHeadAnimation.keyPath = @"strokeStart";
    endHeadAnimation.duration = 1;
    endHeadAnimation.beginTime = 1;
    endHeadAnimation.fromValue = @(0.25);
    endHeadAnimation.toValue = @(1);
    endHeadAnimation.timingFunction = timingFunction;
    
    CABasicAnimation *endTailAnimation = [[CABasicAnimation alloc] init];
    endTailAnimation.keyPath = @"strokeEnd";
    endTailAnimation.duration = 1;
    endTailAnimation.beginTime = 1;
    endTailAnimation.fromValue = @(1);
    endTailAnimation.toValue = @(1);
    endTailAnimation.timingFunction = timingFunction;
    
    CAAnimationGroup *animations = [[CAAnimationGroup alloc] init];
    animations.duration = 2;
    animations.animations = @[headAnimation, tailAnimation, endHeadAnimation, endTailAnimation];
    animations.repeatCount = LINK_MAX;
    
    [layer addAnimation:animations forKey:@"animations"];
}

- (void)finished {
    [self stopAnimation];
}

- (void)stopAnimation {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.1 animations:^{
            if (_LoadingShapeLayer.superlayer) {
                [_LoadingShapeLayer removeAnimationForKey:@"transform.rotation"];
                [_LoadingShapeLayer removeAnimationForKey:@"animations"];
                [_LoadingShapeLayer removeFromSuperlayer];
                _LoadingShapeLayer = nil;
            }
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                super.frame = _frame;
                super.center = _center;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
                    animation.duration = 0.1;
                    animation.removedOnCompletion = YES;
                    [super.layer setCornerRadius:_cornerRadius];
                    [super.layer addAnimation:animation forKey:@"cornerRadius"];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 animations:^{
                        [super setBackgroundImage:_backgroudImage forState:UIControlStateNormal];
                        [super setImage:_image forState:UIControlStateNormal];
                        for (UIView *view in [self subviews]) {
                            view.alpha = 1;
                        }
                    } completion:^(BOOL finished) {
                        super.layer.masksToBounds = _masksToBounds;
                    }];
                }];
            }];
        }];
    });
}

@end
