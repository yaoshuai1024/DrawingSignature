//
//  DrawingBoardView.h
//  画板-电子签名
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardView : UIView

/**
 画线颜色
 */
@property(strong,nonatomic) UIColor *color;

/**
 线宽
 */
@property(assign,nonatomic) CGFloat lineWidth;

/**
 重新绘制
 */
- (void)afreshView;

@end
