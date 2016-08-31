//
//  ChartBackView.h
//  DrawRect
//
//  Created by LiuZhiwei on 16/1/4.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChartBackViewDelegate <NSObject>

- (void)ChartViewLoadMoreData;
- (void)scrollViewDidDragWithCurrentPage:(NSInteger)currentPage;

@end


@interface ChartBackView : UIView

@property (nonatomic, strong) NSArray       *firstPoints;
@property (nonatomic, strong) NSArray       *updatePoints;
@property (nonatomic, assign) NSInteger     pageCount;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) NSArray       *stepCounts;
@property (nonatomic, assign) id<ChartBackViewDelegate> delegate;

- (void)setDateType:(dateType)dateType dataAry:(NSArray *)dataAry;
- (void)setVerticalLables:(NSArray *)verticalLables;
// 加载更多数据
- (void)loadMoreDataWithDataDic:(NSDictionary *)dataDic;

- (void)clearChartView;

@end
