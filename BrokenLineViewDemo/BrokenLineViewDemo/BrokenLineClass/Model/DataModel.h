//
//  DataModel.h
//  BrokenLineViewDemo
//
//  Created by LiuZhiwei on 16/8/30.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DataModel : NSObject

+ (NSArray *)getWeekData;
+ (NSArray *)getMonthData;

+ (NSDictionary *)getMoreWeekData;
+ (NSDictionary *)getMoreMonthData;

@end
