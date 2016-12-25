//
//  UIScrollView+ZYFresh.h
//  SWCampus
//
//  Created by 11111 on 2016/12/18.
//  Copyright © 2016年 WanHang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJRefrshZYDIYHeader,MJRefreshZYDIYFooter;

@interface UIScrollView (ZYFresh)

@property (nonatomic) MJRefrshZYDIYHeader *mj_zyheader;
@property (nonatomic) MJRefreshZYDIYFooter *mj_zyfooter;

@end
