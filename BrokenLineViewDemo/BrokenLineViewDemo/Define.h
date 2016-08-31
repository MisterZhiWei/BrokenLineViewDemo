//
//  Define.h
//  BrokenLineViewDemo
//
//  Created by LiuZhiwei on 16/8/30.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#ifndef Define_h
#define Define_h

typedef enum {
    monthType = 0,
    weekType,
    dayType,
} dateType;


// 常用 尺寸
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define CELL_GAP 14
#define LineH 0.5

#define HEIGHT_PRO [UIScreen mainScreen].bounds.size.height/568
#define WIDTH_PRO [UIScreen mainScreen].bounds.size.width/320


// 常用 字体大小
#define MAX_FONT 14
#define MID_FONT 12
#define MIN_FONT 11

// color
#define YELLOW_COLOR [UIColor colorWithRed:255/255.0 green:163/255.0 blue:31/255.0 alpha:1.0]
#define LIGHT_GRAY_COLOR [UIColor lightGrayColor]

#endif /* Define_h */
