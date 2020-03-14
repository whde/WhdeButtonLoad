//
//  UIButtonLoad.h
//  WhdeButtonDemo
//
//  Created by whde on 16/4/29.
//  Copyright © 2016年 whde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButtonLoad : UIButton
typedef void (^Action)(UIButtonLoad *btn);
// 设置点击事件
- (void)addAction:(Action)action;
// 完成时候通知按钮恢复原状
- (void)finished;

// NS_DEPRECATED_IOS
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents NS_DEPRECATED_IOS(2_0, 3_0, "在 UIButtonLoad 使用 addAction: 方法替代");
@end
