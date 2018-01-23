//
//  ChartView_Cell.h
//  fitbitApp
//
//  Created by LiuZhiwei on 16/2/15.
//  Copyright © 2016年 smartdot. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChartViewCellDelegate <NSObject>
@required
- (void)showStep:(NSString *)stepValue
           point:(NSString *)point
         isMonth:(BOOL)isMonth;

@end

@interface ChartView_Cell : UICollectionViewCell

@property (nonatomic, assign) id <ChartViewCellDelegate> delegate;

- (void)setDateType:(dateType)dateType dataDic:(NSDictionary *)dataDic;

@end
