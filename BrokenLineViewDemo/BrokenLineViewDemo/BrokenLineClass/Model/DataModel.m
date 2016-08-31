//
//  DataModel.m
//  BrokenLineViewDemo
//
//  Created by LiuZhiwei on 16/8/30.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel
+ (NSArray *)getWeekData{
    NSString *dateStr = @"8.15~8.21";
    NSArray *horizontals = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:NSStringFromCGPoint(CGPointMake(0, 24.971))];
    [points addObject:NSStringFromCGPoint(CGPointMake(38.4, 24.9))];
    [points addObject:NSStringFromCGPoint(CGPointMake(76.7, 25.5))];
    [points addObject:NSStringFromCGPoint(CGPointMake(115, 8.4495))];
    [points addObject:NSStringFromCGPoint(CGPointMake(153.3333, 26.353))];
    [points addObject:NSStringFromCGPoint(CGPointMake(191.66667, 30.324))];
    [points addObject:NSStringFromCGPoint(CGPointMake(230, 62.5281))];
    
    NSArray *stepCounts = @[@"11290",@"11303",@"11229",@"13083",@"11140",@"10709",@"7214"];
    NSArray *verticals = @[@"14000",@"10500",@"7000",@"3500",@"0"];
    
    NSDictionary *dic = @{@"dateStr":dateStr,
                          @"horizontals":horizontals,
                          @"points":points,
                          @"stepCounts":stepCounts,
                          @"verticals":verticals,};
    NSArray *ary = @[dic,dic,dic];
    
    return ary;
}
+ (NSArray *)getMonthData{
    NSString *dateStr = @"2016年6月";
    NSArray *horizontals = @[@"6.1",@"6.6",@"6.11",@"6.16",@"6.21",@"6.26",@"6.31"];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:NSStringFromCGPoint(CGPointMake(0, 71.58067))];
    [points addObject:NSStringFromCGPoint(CGPointMake(7.5, 81.59967))];
    [points addObject:NSStringFromCGPoint(CGPointMake(15, 62.40))];
    [points addObject:NSStringFromCGPoint(CGPointMake(22.5, 124.38467))];
    [points addObject:NSStringFromCGPoint(CGPointMake(30, 74.91))];
    [points addObject:NSStringFromCGPoint(CGPointMake(37.5, 72.419))];
    [points addObject:NSStringFromCGPoint(CGPointMake(45, 76.325))];
    [points addObject:NSStringFromCGPoint(CGPointMake(52.5, 91.4897))];
    [points addObject:NSStringFromCGPoint(CGPointMake(60, 92.292))];
    [points addObject:NSStringFromCGPoint(CGPointMake(67.5, 104.59))];
    [points addObject:NSStringFromCGPoint(CGPointMake(75, 81.5136))];
    [points addObject:NSStringFromCGPoint(CGPointMake(82.5, 43.2))];
    [points addObject:NSStringFromCGPoint(CGPointMake(90, 66.58))];
    [points addObject:NSStringFromCGPoint(CGPointMake(97.5, 72.8849))];
    [points addObject:NSStringFromCGPoint(CGPointMake(105, 83.35))];
    [points addObject:NSStringFromCGPoint(CGPointMake(112.5, 81.2198))];
    [points addObject:NSStringFromCGPoint(CGPointMake(120, 86.186))];
    [points addObject:NSStringFromCGPoint(CGPointMake(127.5, 41.0936))];
    [points addObject:NSStringFromCGPoint(CGPointMake(135, 92.0343))];
    [points addObject:NSStringFromCGPoint(CGPointMake(142.5, 95.6))];
    [points addObject:NSStringFromCGPoint(CGPointMake(150, 66.92949))];
    [points addObject:NSStringFromCGPoint(CGPointMake(157.5, 116.193))];
    [points addObject:NSStringFromCGPoint(CGPointMake(165, 69.09))];
    [points addObject:NSStringFromCGPoint(CGPointMake(172.5, 71.014))];
    [points addObject:NSStringFromCGPoint(CGPointMake(180, 0.4228))];
    [points addObject:NSStringFromCGPoint(CGPointMake(187.5, 72.43))];
    [points addObject:NSStringFromCGPoint(CGPointMake(195, 34.02))];
    [points addObject:NSStringFromCGPoint(CGPointMake(202.5, 31.54766))];
    [points addObject:NSStringFromCGPoint(CGPointMake(210, 59.089))];
    [points addObject:NSStringFromCGPoint(CGPointMake(217.5, 32.4578))];
    
    NSArray *stepCounts = @[@"8012",@"6614",@"9293",@"644",@"7548",@"7895",@"7350",@"5234",@"5122",@"3406",@"6626",@"11972",@"8709",@"7830",@"6369",@"6667",@"5974",@"12266",@"5158",@"4660",@"8661",@"1787",@"8359",@"8091",@"17941",@"7893",@"13253",@"13598",@"9755",@"13471"];
    NSArray *verticals = @[@"18000",@"13500",@"9000",@"4500",@"0"];
    
    NSDictionary *dic = @{@"dateStr":dateStr,
                          @"horizontals":horizontals,
                          @"points":points,
                          @"stepCounts":stepCounts,
                          @"verticals":verticals,};
    NSArray *ary = @[dic,dic,dic];
    
    return ary;
    

}

// 加载更多数据
+ (NSDictionary *)getMoreWeekData{
    NSString *dateStr = @"x.xx~x.xx";
    NSArray *horizontals = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:NSStringFromCGPoint(CGPointMake(0, 31.721))];
    [points addObject:NSStringFromCGPoint(CGPointMake(38.4, 67.258))];
    [points addObject:NSStringFromCGPoint(CGPointMake(76.7, 4.349))];
    [points addObject:NSStringFromCGPoint(CGPointMake(115, 44.9227))];
    [points addObject:NSStringFromCGPoint(CGPointMake(153.3333, 97.487))];
    [points addObject:NSStringFromCGPoint(CGPointMake(191.66667, 72.891))];
    [points addObject:NSStringFromCGPoint(CGPointMake(230, 83))];
    
    NSArray *stepCounts = @[@"15836",@"10051",@"20292",@"13687",@"5130",@"9134",@"7488"];
    NSArray *verticals = @[@"21000",@"15750",@"10500",@"5250",@"0"];
    
    NSDictionary *dic = @{@"dateStr":dateStr,
                          @"horizontals":horizontals,
                          @"points":points,
                          @"stepCounts":stepCounts,
                          @"verticals":verticals,};
    return dic;
}

+ (NSDictionary *)getMoreMonthData{
    NSString *dateStr = @"20xx年x月";
    NSArray *horizontals = @[@"7.1",@"7.6",@"7.11",@"7.16",@"7.21",@"7.26",@"7.31"];
    
    NSMutableArray *points = [NSMutableArray array];
    [points addObject:NSStringFromCGPoint(CGPointMake(0, 71.58067))];
    [points addObject:NSStringFromCGPoint(CGPointMake(7.5, 81.59967))];
    [points addObject:NSStringFromCGPoint(CGPointMake(15, 62.40))];
    [points addObject:NSStringFromCGPoint(CGPointMake(22.5, 124.38467))];
    [points addObject:NSStringFromCGPoint(CGPointMake(30, 74.91))];
    [points addObject:NSStringFromCGPoint(CGPointMake(37.5, 72.419))];
    [points addObject:NSStringFromCGPoint(CGPointMake(45, 76.325))];
    [points addObject:NSStringFromCGPoint(CGPointMake(52.5, 91.4897))];
    [points addObject:NSStringFromCGPoint(CGPointMake(60, 92.292))];
    [points addObject:NSStringFromCGPoint(CGPointMake(67.5, 104.59))];
    [points addObject:NSStringFromCGPoint(CGPointMake(75, 81.5136))];
    [points addObject:NSStringFromCGPoint(CGPointMake(82.5, 43.2))];
    [points addObject:NSStringFromCGPoint(CGPointMake(90, 66.58))];
    [points addObject:NSStringFromCGPoint(CGPointMake(97.5, 72.8849))];
    [points addObject:NSStringFromCGPoint(CGPointMake(105, 83.35))];
    [points addObject:NSStringFromCGPoint(CGPointMake(112.5, 81.2198))];
    [points addObject:NSStringFromCGPoint(CGPointMake(120, 86.186))];
    [points addObject:NSStringFromCGPoint(CGPointMake(127.5, 41.0936))];
    [points addObject:NSStringFromCGPoint(CGPointMake(135, 92.0343))];
    [points addObject:NSStringFromCGPoint(CGPointMake(142.5, 95.6))];
    [points addObject:NSStringFromCGPoint(CGPointMake(150, 66.92949))];
    [points addObject:NSStringFromCGPoint(CGPointMake(157.5, 116.193))];
    [points addObject:NSStringFromCGPoint(CGPointMake(165, 69.09))];
    [points addObject:NSStringFromCGPoint(CGPointMake(172.5, 71.014))];
    [points addObject:NSStringFromCGPoint(CGPointMake(180, 0.4228))];
    [points addObject:NSStringFromCGPoint(CGPointMake(187.5, 72.43))];
    [points addObject:NSStringFromCGPoint(CGPointMake(195, 34.02))];
    [points addObject:NSStringFromCGPoint(CGPointMake(202.5, 31.54766))];
    [points addObject:NSStringFromCGPoint(CGPointMake(210, 59.089))];
    [points addObject:NSStringFromCGPoint(CGPointMake(217.5, 32.4578))];
    
    NSArray *stepCounts = @[@"8012",@"6614",@"9293",@"644",@"7548",@"7895",@"7350",@"5234",@"5122",@"3406",@"6626",@"11972",@"8709",@"7830",@"6369",@"6667",@"5974",@"12266",@"5158",@"4660",@"8661",@"1787",@"8359",@"8091",@"17941",@"7893",@"13253",@"13598",@"9755",@"13471"];
    NSArray *verticals = @[@"18000",@"13500",@"9000",@"4500",@"0"];
    
    NSDictionary *dic = @{@"dateStr":dateStr,
                          @"horizontals":horizontals,
                          @"points":points,
                          @"stepCounts":stepCounts,
                          @"verticals":verticals,};

    return dic;
}
@end
