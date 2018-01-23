//
//  ViewController.m
//  BrokenLineViewDemo
//
//  Created by LiuZhiwei on 16/8/30.
//  Copyright © 2016年 smartdot.mau. All rights reserved.
//

#import "ViewController.h"
#import "ChartBackView.h"
#import "DataModel.h"

@interface ViewController ()<ChartBackViewDelegate>{

    ChartBackView       *chartView;
}

@property (nonatomic, assign) dateType dateType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    [self addSubViews];
}

- (void)addSubViews{
    chartView = [[ChartBackView alloc] initWithFrame:CGRectMake(0, 140*SCREEN_HEIGHT/568-10*WIDTH_PRO, SCREEN_WIDTH, 200*SCREEN_WIDTH/320)];
    chartView.delegate = self;
    [self.view addSubview:chartView];
    
    self.dateType = monthType;
    NSArray *dataAry = [DataModel getMonthData];
    [chartView setDateType:self.dateType dataAry:dataAry];
    
    NSArray *verticals = [dataAry[0] objectForKey:@"verticals"];
    [chartView setVerticalLables:verticals];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 140*SCREEN_HEIGHT/568+20*WIDTH_PRO + 200*SCREEN_WIDTH/320, 150, 50)];
    [btn setTitle:@"周/月切换" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeBtnClicked{
    if (self.dateType == monthType) {
        self.dateType = weekType;
        NSArray *dataAry = [DataModel getWeekData];
        [chartView setDateType:self.dateType dataAry:dataAry];
        
        NSArray *verticals = [dataAry[0] objectForKey:@"verticals"];
        [chartView setVerticalLables:verticals];
    }
    else {
        self.dateType = monthType;
        NSArray *dataAry = [DataModel getMonthData];
        [chartView setDateType:self.dateType dataAry:dataAry];
        
        NSArray *verticals = [dataAry[0] objectForKey:@"verticals"];
        [chartView setVerticalLables:verticals];

    }
}

#pragma mark ChartViewDelegate
- (void)ChartViewLoadMoreData{
    NSDictionary *dic;
    
    if (self.dateType == weekType) {
        dic = [DataModel getMoreWeekData];
    }
    else if (self.dateType == monthType){
        dic = [DataModel getMoreMonthData];
    }
    
    [chartView loadMoreDataWithDataDic:dic];
    
    NSArray *verticals = [dic objectForKey:@"verticals"];
    [chartView setVerticalLables:verticals];
}

- (void)scrollViewDidDragWithCurrentPage:(NSInteger)currentPage{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
