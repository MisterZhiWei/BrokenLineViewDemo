//
//  ChartView_Cell.m
//  fitbitApp
//
//  Created by LiuZhiwei on 16/2/15.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import "ChartView_Cell.h"
#import "BrokenLineView.h"

@interface ChartView_Cell ()<BrokenLineViewDelegate>

@property (nonatomic, strong) UIView    *brokenView;
@property (nonatomic, assign) dateType  dateType;

@end

@implementation ChartView_Cell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.brokenView = [[UIView alloc] init ];
        self.brokenView.backgroundColor = [UIColor clearColor];
        self.brokenView.frame = self.contentView.bounds;
        [self.contentView addSubview:self.brokenView];
    }

    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.brokenView.frame = self.contentView.bounds;
}

- (void)setDateType:(dateType)dateType dataDic:(NSDictionary *)dataDic{
    for (UIView *view in [self.brokenView subviews]) {
        [view removeFromSuperview];
    }
    
    // 重绘要移除重赋对象
    if (dateType == dayType) {  // 画 天 横坐标
        [self DrawPointWithPointCount:7 HorizontalLables:[dataDic objectForKey:@"horizontals"]];
    }
    else if (dateType == weekType){ // 画 周 横坐标
        [self DrawPointWithPointCount:7 HorizontalLables:[dataDic objectForKey:@"horizontals"]];
    }
    else if (dateType == monthType){ // 画 月 横坐标
        [self DrawPointWithPointCount:7 HorizontalLables:[dataDic objectForKey:@"horizontals"]];
    }
    self.dateType = dateType;
    [self ShowViewWithDateType:dateType
                        Points:[dataDic objectForKey:@"points"]
                    stepCounts:[dataDic objectForKey:@"stepCounts"]];
}

- (void)DrawPointWithPointCount:(NSInteger)pointCount
               HorizontalLables:(NSArray *)horizontalLables{
    CGFloat margin = (self.brokenView.frame.size.width -  pointCount*32 )/(pointCount-1);
    
    // 添加横坐标轴lable
    UIView *horizonView = [[UIView alloc] init];
    horizonView.backgroundColor = [UIColor clearColor];
    horizonView.frame = CGRectMake(0.0f, self.brokenView.frame.size.height-20*WIDTH_PRO, self.brokenView.frame.size.width, 40);
    
    for (int i = 0; i < horizontalLables.count; i++) {
        UILabel *lab = [self drawLableWithPoint:CGPointMake(i*(margin+32) ,0) text:horizontalLables[i] isVertical:NO];
        [horizonView addSubview:lab];
    }
    
    [self.brokenView addSubview:horizonView];
}

- (void)ShowViewWithDateType:(dateType)dateType
                      Points:(NSArray *)points
                  stepCounts:(NSArray *)stepCounts{
    BrokenLineView *brokenView = [[BrokenLineView alloc] initWithFrame:CGRectMake(4.0f,3, self.brokenView.frame.size.width, 33*WIDTH_PRO*4)];
    brokenView.delegate = self;
    brokenView.backgroundColor = [UIColor clearColor];
    brokenView.points = points;
    brokenView.stepCounts = stepCounts;
    [self.brokenView addSubview:brokenView];
}

- (UILabel *)drawLableWithPoint:(CGPoint)point text:(NSString *)text isVertical:(BOOL)isVertical{
    CGRect frame = CGRectMake(point.x, point.y, 35, 10);
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = [UIFont systemFontOfSize:12];
    lab.frame = frame;
    
    return lab;
}

#pragma mark BrokenLineViewDelegate
- (void)showStepValue:(NSString *)stepValue point:(NSString *)point{
    if ([self.delegate respondsToSelector:@selector(showStep:point:isMonth:)]) {
        if (self.dateType == monthType) {
            [self.delegate showStep:stepValue point:point isMonth:YES];
        }
        else {
            [self.delegate showStep:stepValue point:point isMonth:NO];
        }
        
    }
}

@end
