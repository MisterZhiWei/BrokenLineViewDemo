//
//  BrokenLineView.m
//  DrawRect
//
//  Created by LiuZhiwei on 16/1/5.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import "BrokenLineView.h"

@implementation BrokenLineView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    for (int i = 0; i < self.points.count; i++) {
        CGPoint point = CGPointFromString(self.points[i]);
        CGFloat disX = point.x - touchPoint.x;
        CGFloat disY = point.y - touchPoint.y;

        if (fabs(disX) < 15 &&  fabs(disY) < 10 ) {
            if ([self.delegate respondsToSelector:@selector(showStepValue:point:)]) {
                [self.delegate showStepValue:self.stepCounts[i] point:NSStringFromCGPoint(point)];
                break;
            }
        }
    }
    
}

- (void)drawRect:(CGRect)rect{
    if (!self.points) {
        return;
    }
    
    NSArray *points = self.points;

    // 1.获取当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    CGFloat bottomH = 200.0;
    
    if (points.count > 1) {
        // 2.画渐变图
        for (int i  = 0; i < points.count ; i++) {
            CGPoint pointFirst = CGPointFromString(points[i]);
            CGPoint secondPoint ;
            
            if (i < points.count - 1) {
                secondPoint = CGPointFromString(points[i+1]);
            }
            CGContextMoveToPoint(currentContext, pointFirst.x, pointFirst.y);
            CGContextAddLineToPoint(currentContext, pointFirst.x, bottomH);
            CGContextAddLineToPoint(currentContext, secondPoint.x, bottomH);
            CGContextAddLineToPoint(currentContext, secondPoint.x, secondPoint.y);
        }
        
        CGContextClip(currentContext);
        CGFloat locations[2] = {0.0, 0.7};
        CGFloat components[8] = {1.0, 1.0, 1.0, 0.4,  0.0, 0.0, 0.0, 0.0};
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
        
        // 渐变 从Y值最小的开始  到Y值最大的结束
        CGPoint startPoint = CGPointMake(0, 50);
        CGPoint endPoint = CGPointMake(0, bottomH);
        CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation);
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorspace);
    }
    
    // 2.绘制折线 并添加圆点
    UIColor *lineColor = [UIColor colorWithRed:243/255.0 green:171/255.0 blue:101/255.0 alpha:1.0];
    for (int i = 0; i < points.count; i++) {
        CGPoint pointFirst = CGPointFromString(points[i]);
        UIView *point = [self makePointX:pointFirst.x-3.5 Y:pointFirst.y-4];
        [self addSubview:point];
        UIBezierPath *path = [[UIBezierPath alloc] init];
        if (i < points.count-1) {
            CGPoint pointSecond = CGPointFromString(points[i+1]);
            [path moveToPoint:pointFirst];
            [path addLineToPoint:pointSecond];
            path.lineWidth = 3.4;
            [lineColor setStroke];
        }
        [path stroke];
    }
}

// 画白点
- (UIView *)makePointX:(CGFloat)x Y:(CGFloat)y{
    UIView *point = [[UIView alloc] initWithFrame:CGRectMake(x, y, 7, 7)];
    point.backgroundColor = [UIColor whiteColor];
    point.layer.cornerRadius = 3.5;
    point.layer.masksToBounds = YES;
    return point;
}


@end
