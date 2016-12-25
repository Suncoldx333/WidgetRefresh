//
//  ViewController.h
//  Refresh
//
//  Created by 11111 on 2016/12/25.
//  Copyright © 2016年 ZheJiang WanHang Mdt InfoTech CO.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+ZYFresh.h"
#import "MJRefresh.h"
#import "MJRefrshZYDIYHeader.h"
#import "MJRefreshZYDIYFooter.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *testTableView;
@property (nonatomic,strong) NSMutableArray *teArr;

@end

