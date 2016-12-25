//
//  ViewController.m
//  Refresh
//
//  Created by 11111 on 2016/12/25.
//  Copyright © 2016年 ZheJiang WanHang Mdt InfoTech CO.,Ltd. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width//屏幕宽度
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define hexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

@synthesize testTableView,teArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
    teArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i < 15; i++) {
        [teArr addObject:[NSNumber numberWithInteger:i]];
    }
}

-(void)initUI{
    
    self.view.backgroundColor = hexColor(0xb2b2b2);
    
    testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    testTableView.delegate = self;
    testTableView.dataSource = self;
    testTableView.backgroundColor = hexColor(0xffffff);
    [self.view addSubview:testTableView];
    
    testTableView.mj_zyheader = [MJRefrshZYDIYHeader ZYHeaderWithRefreshingBlock:^{
        NSLog(@"header");
        [testTableView.mj_zyheader endRefreshing];
    }];
    
    testTableView.mj_zyfooter = [MJRefreshZYDIYFooter footerWithRefreshingBlock:^{
        NSLog(@"footer");
        [testTableView.mj_zyfooter endRefreshingWithNoMoreData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    UILabel *teLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    teLabel.text = [teArr objectAtIndex:indexPath.row];
    teLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:teLabel];
    return cell;
}

@end
