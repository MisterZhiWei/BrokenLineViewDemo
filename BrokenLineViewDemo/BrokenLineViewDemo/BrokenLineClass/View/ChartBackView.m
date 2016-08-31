//
//  ChartBackView.m
//  DrawRect
//
//  Created by LiuZhiwei on 16/1/4.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import "ChartBackView.h"
#import "BrokenLineView.h"
#import "ChartLayout.h"
#import "ChartView_Cell.h"

#define tagCount 20018
#define Labtag  10001
#define Horizontal 30099
#define SCROLL_W self.frame.size.width-85

@interface ChartBackView ()<UICollectionViewDelegate,
 UICollectionViewDataSource, UIScrollViewDelegate, ChartViewCellDelegate>
@property (nonatomic, strong) BrokenLineView    *drawView;
@property (nonatomic, assign) dateType          dateType;
@property (nonatomic, strong) UIView            *verticalBackView;
@property (nonatomic, assign) BOOL              isUpDate;
@property (nonatomic, assign) NSInteger         currentPage;
@property (nonatomic, strong) NSMutableArray    *brokenViews;
@property (nonatomic, strong) UIView            *brokenView;
@property (nonatomic, strong) UICollectionView  *collectionView;
@property (nonatomic, strong) UILabel           *showValueLab;
@property (nonatomic, strong) CAShapeLayer      *lastShapeLayer;
@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, assign) NSInteger         circleTimes;
@end

@implementation ChartBackView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.brokenViews = [NSMutableArray array];
        [self initSubView];
    }
    return self;
}

- (void)initSubView{
    self.showValueLab = [[UILabel alloc] init];
    self.showValueLab.textAlignment = NSTextAlignmentCenter;
    self.showValueLab.font = [UIFont systemFontOfSize:MID_FONT];
    self.showValueLab.textColor = YELLOW_COLOR;
    self.showValueLab.hidden = YES;
    [self addSubview:self.showValueLab];
}

- (void)drawRect:(CGRect)rect{
    // 绘制五条横线
    UIBezierPath *pathH = [[UIBezierPath alloc] init];
    CGFloat line_gap = 33*SCREEN_WIDTH/320;
    
    for (int i = 0; i < 5; i++) {
        UIView *extremePoint = [self makePointX:50*WIDTH_PRO Y:2.5+10*WIDTH_PRO + i*line_gap];
        [self addSubview:extremePoint];
        [pathH moveToPoint:CGPointMake(50*WIDTH_PRO, 5+10*WIDTH_PRO+i*line_gap)];
        [pathH addLineToPoint:CGPointMake(self.frame.size.width-30*WIDTH_PRO,5+10*WIDTH_PRO+i*line_gap)];
        [[UIColor whiteColor] setStroke];
        pathH.lineWidth = 1;
    }
    [pathH stroke];
}

- (void)setDateType:(dateType)dateType dataAry:(NSArray *)dataAry{

    [self clearShowLab];
    self.dateType = dateType;
    
    if (dataAry.count > 0) {
        self.collectionView.hidden = NO;;
        [self.collectionView removeFromSuperview];
        [self.brokenViews removeAllObjects];
        [dataAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.brokenViews addObject:obj];
        }];
        
        CGFloat W = self.frame.size.width;
        CGFloat H = self.frame.size.height;
        CGFloat w = W-80*WIDTH_PRO;
        CGFloat h = H-40*WIDTH_PRO;
        
        CGRect tableView_frame = CGRectMake(50*WIDTH_PRO,10*WIDTH_PRO+5,w ,h);
        
        ChartLayout *layout = [[ChartLayout alloc] init];
        layout.itemSize = CGSizeMake(w, h);
        layout.minimumLineSpacing = 0.0;
        // collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:tableView_frame
                                                 collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        static NSString * ID = @"collection_cell";
        [self.collectionView registerClass:[ChartView_Cell class]
                forCellWithReuseIdentifier:ID];
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView setContentOffset:CGPointMake(self.brokenViews.count*SCREEN_WIDTH, 0)];
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.collectionView];
    }
    
}

#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.brokenViews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * ID = @"collection_cell";
    ChartView_Cell *cell = (ChartView_Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    cell.delegate = self;
    [cell setDateType:self.dateType dataDic:self.brokenViews[indexPath.row]];
 
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self clearShowLab];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (scrollView.contentOffset.x < -40) {
        // 向右滑动
        [self loadMoreData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 得到每页宽度
    CGFloat pageWidth = scrollView.frame.size.width;
    // 根据当前的x坐标和页宽度计算出当前页数
    NSInteger currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (!self.currentPage) {
        self.currentPage = currentPage;
        if ([self.delegate respondsToSelector:@selector(scrollViewDidDragWithCurrentPage:)]) {
            [self.delegate scrollViewDidDragWithCurrentPage:currentPage];
        }
    } else if (self.currentPage != currentPage){
        if ([self.delegate respondsToSelector:@selector(scrollViewDidDragWithCurrentPage:)]) {
            [self.delegate scrollViewDidDragWithCurrentPage:currentPage];
        }
        self.currentPage = currentPage;
    }
}

// 纵坐标设置
- (void)setVerticalLables:(NSArray *)verticalLables{

    if (verticalLables.count > 0) {
        if (self.verticalBackView) {
            [self.verticalBackView removeFromSuperview];
        }
        self.verticalBackView = [[UIView alloc] initWithFrame:CGRectMake(5, 2+10*WIDTH_PRO, 30, 30-2.5+[verticalLables count]*40 - 5)];
        
        // 添加纵坐标轴lable
        for (int i = 0; i < verticalLables.count ; i++) {
            UILabel *lab = [self drawLableWithPoint:CGPointMake(0, 2.5+i*33*WIDTH_PRO- 5) text:verticalLables[i] isVertical:YES];
            lab.tag = i+Labtag;
            [self.verticalBackView addSubview:lab];
        }
        [self addSubview:self.verticalBackView];
    }
}

- (UILabel *)drawLableWithPoint:(CGPoint)point text:(NSString *)text isVertical:(BOOL)isVertical{

    CGRect frame = CGRectMake(point.x, point.y, 50, 10);
    UILabel *lab = [[UILabel alloc] init];
    lab.text = text;
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:13];
    lab.frame = frame;

    return lab;
}

- (UIView *)makePointX:(CGFloat)x Y:(CGFloat)y{
    
    UIView *point = [[UIView alloc] initWithFrame:CGRectMake(x, y, 4, 4)];
    point.backgroundColor = [UIColor whiteColor];
    point.layer.cornerRadius = 2;
    point.layer.masksToBounds = YES;
    
    return point;
}

- (void)loadMoreData{
    if ([self.delegate respondsToSelector:@selector(ChartViewLoadMoreData)]) {
        [self.delegate ChartViewLoadMoreData];
    }
}

- (void)loadMoreDataWithDataDic:(NSDictionary *)dataDic{
    // 纵坐标修改
    NSArray *vertical = [dataDic objectForKey:@"verticals"];
    [self setVerticalLables:vertical];
    [self.brokenViews insertObject:dataDic atIndex:0];
    [self.collectionView reloadData];
}

#pragma mark ChartViewCellDelegate
- (void)showStep:(NSString *)stepValue
           point:(NSString *)point
         isMonth:(BOOL)isMonth{
    CGFloat gapX = CGPointFromString(point).x + 50*WIDTH_PRO + 4.0;
    CGFloat gapY = CGPointFromString(point).y + 10*WIDTH_PRO+8;

    self.showValueLab.frame = CGRectMake(gapX - 30, gapY, 60, 10);
   
    [UIView animateWithDuration:0.25 animations:^{
        self.showValueLab.frame = CGRectMake(gapX - 30, 0, 60, 10);
    }];

    self.showValueLab.text = stepValue;
    self.showValueLab.hidden = NO;
    
    if (isMonth) {
        CGFloat divationY = self.bounds.size.height/2;
        if (SCREEN_HEIGHT > 500) {
            divationY += 33*SCREEN_WIDTH/640+10*WIDTH_PRO - 5;
        }
        
        CGPoint startPoint = CGPointMake(gapX, -divationY);
        CGPoint endPoint   =  CGPointMake(gapX, gapY-10-divationY);
        [self makeDottedLineFromePoint:endPoint toPoint:startPoint];
    }
}

- (void)makeDottedLineFromePoint:(CGPoint)starPoint toPoint:(CGPoint)endPoint{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色
    [shapeLayer setStrokeColor:[LIGHT_GRAY_COLOR CGColor]];
    
    // 1.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3是线的宽度 2是每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:2],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, starPoint.x, starPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x,endPoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
   
    // 添加虚线到视图
    if (self.lastShapeLayer) { 
        [self.layer replaceSublayer:self.lastShapeLayer with:shapeLayer];
    } else {
        [self.layer addSublayer:shapeLayer];
    }
    self.lastShapeLayer = shapeLayer;
    
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0;
    self.circleTimes = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(circleAnimation)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)circleAnimation{
    if (self.circleTimes == 5) {
        [self.timer invalidate];
    } else {
        self.lastShapeLayer.strokeEnd += 0.8;
        self.circleTimes += 1;
    }
}

- (void)clearShowLab{
    self.showValueLab.hidden = YES;
    [self replaceLastShapeLayerWithClearLayer];
}

// 移除虚线和显示数字
- (void)replaceLastShapeLayerWithClearLayer{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer = self.lastShapeLayer;
    // 设置虚线颜色
    [shapeLayer setStrokeColor:[[UIColor clearColor] CGColor]];
    [self.layer replaceSublayer:self.lastShapeLayer with:shapeLayer];
    
}

- (void)clearChartView{
    self.collectionView.hidden = YES;
    NSArray *verties = [NSArray arrayWithObjects:@"2000",@"1500",@"1000",@"500",@"0", nil];
    [self setVerticalLables:verties];
}

@end
