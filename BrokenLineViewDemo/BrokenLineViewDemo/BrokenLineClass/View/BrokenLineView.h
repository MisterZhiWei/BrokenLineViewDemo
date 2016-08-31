//
//  BrokenLineView.h
//  DrawRect
//
//  Created by LiuZhiwei on 16/1/5.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BrokenLineViewDelegate <NSObject>

- (void)showStepValue:(NSString *)stepValue point:(NSString *)point;

@end

@interface BrokenLineView : UIView
@property (nonatomic, strong) NSArray   *points;
@property (nonatomic, strong) NSArray   *stepCounts;
@property (nonatomic, assign) id <BrokenLineViewDelegate> delegate;

@end
