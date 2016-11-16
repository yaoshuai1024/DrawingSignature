//
//  DrawingBoardView.m
//  画板-电子签名
//
//  Created by yaoshuai on 2016/11/16.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "DrawingBoardView.h"
#import "YSBezierPath.h"

@interface DrawingBoardView()<UIGestureRecognizerDelegate>
{
    // 声明路径数组，保存多条不连续的路径
    NSMutableArray<YSBezierPath *> *pathArray;
}

/**
 当前画线路径
 */
@property(nonatomic,strong) YSBezierPath *currentPath;
@end

@implementation DrawingBoardView

- (void)awakeFromNib{
    [super awakeFromNib];
    pathArray = [NSMutableArray array];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    recognizer.delegate = self;
    [self addGestureRecognizer:recognizer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint beginPoint = [touches.anyObject locationInView:self];
    
    _currentPath = [YSBezierPath bezierPath];
    _currentPath.lineWidth = _lineWidth;
    _currentPath.color = _color;
    _currentPath.lineCapStyle = kCGLineCapRound; // 设置线头样式
    _currentPath.lineJoinStyle = kCGLineJoinRound; // 设置接头样式
    [_currentPath moveToPoint:beginPoint];
    [pathArray addObject:_currentPath];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint movedPoint = [touches.anyObject locationInView:self];
    [_currentPath addLineToPoint:movedPoint];
    [self setNeedsDisplay];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer velocityInView:self];
    NSLog(@"%f--%f",point.x,point.y);
}

- (void)drawRect:(CGRect)rect {
    for (YSBezierPath *path in pathArray) {
        [path.color setStroke];
        [path stroke];
    }
}

#pragma mark - 重新绘制
- (void)afreshView{
    [pathArray removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
