//
//  UIScrollView+ZYFresh.m
//  SWCampus
//
//  Created by 11111 on 2016/12/18.
//  Copyright © 2016年 WanHang. All rights reserved.
//

#import "UIScrollView+ZYFresh.h"
#import "MJRefrshZYDIYHeader.h"
#import "MJRefreshZYDIYFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (ZYFresh)

static const char MJRefreshZYDIYHeaderKey = '\0';

-(void)setMj_zyheader:(MJRefrshZYDIYHeader *)mj_zyheader{
    if (mj_zyheader != self.mj_zyheader) {
        [self.mj_zyheader removeFromSuperview];
        [self insertSubview:mj_zyheader atIndex:0];
        [self willChangeValueForKey:@"mj_zyheader"];
        objc_setAssociatedObject(self, &MJRefreshZYDIYHeaderKey, mj_zyheader, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_ziheader"];
    }
}

-(MJRefrshZYDIYHeader *)mj_zyheader{
    return objc_getAssociatedObject(self, &MJRefreshZYDIYHeaderKey);
}


static const char MJRefreshZYDIYFooterKey = '\0';

-(void)setMj_zyfooter:(MJRefreshZYDIYFooter *)mj_zyfooter{
    if (mj_zyfooter != self.mj_zyfooter) {
        [self.mj_zyfooter removeFromSuperview];
        [self insertSubview:mj_zyfooter atIndex:0];
        [self willChangeValueForKey:@"mj_zyfooter"];
        objc_setAssociatedObject(self, &MJRefreshZYDIYFooterKey, mj_zyfooter, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"mj_zyfooter"];
    }
}

-(MJRefreshZYDIYFooter *)mj_zyfooter{
    return objc_getAssociatedObject(self, &MJRefreshZYDIYFooterKey);
}
@end
