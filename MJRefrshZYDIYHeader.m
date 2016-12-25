//
//  MJRefrshZYDIYHeader.m
//  SWCampus
//
//  Created by 11111 on 2016/12/18.
//  Copyright © 2016年 WanHang. All rights reserved.
//

#import "MJRefrshZYDIYHeader.h"

#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width//屏幕宽度
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define hexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

@interface MJRefrshZYDIYHeader ()

@property (nonatomic,strong) UIActivityIndicatorView *headerIndi;
@property (nonatomic,strong) headerView *pullProgress;
@property (assign, nonatomic) CGFloat insetTDelta;

@end

@implementation MJRefrshZYDIYHeader

-(UIActivityIndicatorView *)headerIndi{
    if (!_headerIndi) {
        UIActivityIndicatorView *head = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        head.hidesWhenStopped = YES;
        CGAffineTransform trans = CGAffineTransformMakeScale(1.25f, 1.25f);
        head.transform = trans;
        [self addSubview:_headerIndi = head];
    }
    return _headerIndi;
}

-(headerView *)pullProgress{
    if (!_pullProgress) {
        headerView *pull = [[headerView alloc]initWithFrame:CGRectMake(0, 55 - 7, ScreenWidth, 25)];
        [self addSubview:_pullProgress = pull];
    }
    return _pullProgress;
}

+(instancetype)ZYHeaderWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    MJRefrshZYDIYHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}

-(void)prepare{
    [super prepare];
    self.backgroundColor = hexColor(0xe6e6e6);
    [self.headerIndi stopAnimating];
    self.pullProgress.hidden = NO;
    self.mj_h = 55;
    self.mj_y = -55;
}

-(void)placeSubviews{
    [super placeSubviews];
    
    self.headerIndi.center = CGPointMake(self.mj_w/2, 27.5);
    CGFloat centerY = self.pullProgress.center.y;
    self.pullProgress.center = CGPointMake(self.mj_w/2, centerY);
    
}

-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
    // 在刷新的refreshing状态
//    if (self.state == MJRefreshStateRefreshing) {
//        if (self.window == nil) return;
//        
//        // sectionheader停留解决
//        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
//        insetT = insetT > self.mj_h + _scrollViewOriginalInset.top ? self.mj_h + _scrollViewOriginalInset.top : insetT;
//        self.scrollView.mj_insetT = insetT;
//        
//        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
//        NSLog(@"insetTDelta====%f",self.insetTDelta);
//        return;
//    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    CGFloat normal2pullingOffsetY = -55;

    [self.pullProgress changeDataWithOffset:offsetY];
    
    // 头部控件刚好出现的offsetY
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    if (offsetY < normal2pullingOffsetY) {
        self.mj_y = offsetY;
        self.mj_h = -offsetY;
//        self.headerIndi.center = CGPointMake(self.mj_w/2, 15 + 12.5);

    }else{
        self.mj_y = -55;
        self.mj_h = 55;
    }
    
    CGFloat pullingPercent = (happenOffsetY - offsetY) / 55;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

-(void)setState:(MJRefreshState)state{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState != MJRefreshStateRefreshing) return;
        
        // 保存刷新时间
//        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 恢复inset和offsetns
//        NSLog(<#NSString * _Nonnull format, ...#>)
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            
            self.scrollView.mj_insetT += -55;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.headerIndi stopAnimating];
            self.pullProgress.hidden = NO;
            self.pullingPercent = 0.0;
            
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
//        [self.scrollView.mj_insetT set]
//        if (self.endRefreshingCompletionBlock) {
//            self.endRefreshingCompletionBlock();
//        }
        
    } else if (state == MJRefreshStateRefreshing) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + 55;
                // 增加滚动区域top
                self.scrollView.mj_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }else if (state == MJRefreshStatePulling){
        self.pullProgress.hidden = YES;
        [self.headerIndi startAnimating];
    }
}

-(void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MJRefreshStateIdle;
    });
}

@end
