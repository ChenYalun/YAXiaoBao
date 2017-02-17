//
//  YAHomeHeaderView.m
//  XiaoBao
//
//  Created by 陈亚伦 on 2017/2/16.
//  Copyright © 2017年 陈亚伦. All rights reserved.
//

#import "YAHomeHeaderView.h"
#import "YAStoryHeaderView.h"
#define kHeaderViewHeight 200
#define kHeaderViewCount 5
@interface YAHomeHeaderView()<UIScrollViewDelegate>
//@property (nonatomic,strong) NSMutableArray <YAStoryHeaderView *> *headerViews;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *picScrollView;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger currentPageIndex;
@property (nonatomic,strong) YAStoryHeaderView *leftView;
@property (nonatomic,strong) YAStoryHeaderView *centerView;
@property (nonatomic,strong) YAStoryHeaderView *rightView;
@end
@implementation YAHomeHeaderView
#pragma mark - 懒加载
//- (NSMutableArray<YAStoryHeaderView *> *)headerViews {
//    if (_headerViews == nil) {
//        _headerViews = [NSMutableArray array];
//        
//        for (NSInteger i = 0; i < 3; i++) {
//            YAStoryHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:[YAStoryHeaderView className] owner:nil options:nil].firstObject;
//            [self.picScrollView addSubview:headerView];
//            [_headerViews addObject:headerView];
//        }
//
//    }
//    return _headerViews;
//}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc]init];
        //总页数
        _pageControl.numberOfPages = kHeaderViewCount;   //NSInteger类型
        //当前第几页（范围是 0 ~ （numberOfPages - 1））
        _pageControl.currentPage = 0;  //NSInteger类型
        //只有一页的时候隐藏
        _pageControl.hidesForSinglePage = YES;//默认为NO
        //设置当前页指示器的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //设置指示器的颜色
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        
    }
    return _pageControl;
}

- (UIScrollView *)picScrollView {
    if (_picScrollView == nil) {
        _picScrollView = [[UIScrollView alloc] init];
        _picScrollView.showsHorizontalScrollIndicator = NO;
        _picScrollView.pagingEnabled = YES;
        _picScrollView.delegate = self;
        
        // 设置无限循环
        _picScrollView.contentSize = CGSizeMake(kScreenWidth * 3, kHeaderViewHeight);
        [_picScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }
    return _picScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //         通过xib创建的view无法显示
        //        YAStoryHeaderView *headerView = [[YAStoryHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        // 添加scrollView
        [self addSubview:self.picScrollView];
        
        // 添加imageView
        self.leftView = [[NSBundle mainBundle] loadNibNamed:[YAStoryHeaderView className] owner:nil options:nil].firstObject;
        self.centerView = [[NSBundle mainBundle] loadNibNamed:[YAStoryHeaderView className] owner:nil options:nil].firstObject;
        self.rightView = [[NSBundle mainBundle] loadNibNamed:[YAStoryHeaderView className] owner:nil options:nil].firstObject;
        [self.picScrollView addSubview:self.leftView];
        [self.picScrollView addSubview:self.centerView];
        [self.picScrollView addSubview:self.rightView];
        // 添加pageControl,要注意添加到自身上
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
//    [self.headerViews enumerateObjectsUsingBlock:^(YAStoryHeaderView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
//        view.frame = CGRectMake(kScreenWidth * idx, 0, kScreenWidth, kHeaderViewHeight);
//    }];
    self.leftView.frame = CGRectMake(0, 0, kScreenWidth, kHeaderViewHeight);
    self.centerView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kHeaderViewHeight);
    self.rightView.frame = CGRectMake(2 * kScreenWidth, 0, kScreenWidth, kHeaderViewHeight);
    
    
    // 添加到视图
    self.picScrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, 165, kScreenWidth, 34);
}

- (void)setStoryItems:(NSArray *)storyItems {
    _storyItems = storyItems;
    
    // 遍历YAStoryHeaderView
    // NSEnumerationConcurrent并发遍历 会出现问题
    // NSEnumerationReverse 逆制
    /*
    [self.headerViews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(YAStoryHeaderView *view, NSUInteger index, BOOL *stop) {
        view.frame = CGRectMake(kScreenWidth * index, 0, kScreenWidth, 200);
            view.story = storyItems[index];

    }];
    */
    
    // 普通遍历
    /*
    for (NSInteger i = 0; i < 5; i++) {
        self.headerViews[i].frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, 200);
        self.headerViews[i].story = storyItems[i];
    }
     */

    
//    [self.headerViews enumerateObjectsUsingBlock:^(YAStoryHeaderView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
//        view.story = storyItems[idx];
//    }];
    
    
    [self reloadImage];
    [self setupTimer];
}
- (void)pre {
    if (self.pageControl.currentPage == 0) {
        self.pageControl.currentPage = 4;
    } else {
        self.pageControl.currentPage -= 1;
    }
    [self.picScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)next {
    if (self.pageControl.currentPage == 4) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage += 1;
    }
    [self.picScrollView setContentOffset:CGPointMake(2 * kScreenWidth, 0) animated:YES];
}
- (void)reloadImage {
    NSInteger leftImageIndex,rightImageIndex;


    
    leftImageIndex = (self.pageControl.currentPage + 4) % 5;
    rightImageIndex = (self.pageControl.currentPage + 1) % 5;
    
    self.centerView.story = self.storyItems[self.pageControl.currentPage];
    self.leftView.story = self.storyItems[leftImageIndex];
    self.rightView.story = self.storyItems[rightImageIndex];
    
    
    
    
}
#pragma mark - 定时器
- (void)setupTimer {
    self.timer = [NSTimer timerWithTimeInterval:5.0 block:^(NSTimer * _Nonnull timer) {
       
        [self next];
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}



#pragma mark - 代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self reloadImage];
    [self.picScrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止定时器
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
    
    
    if (scrollView.contentOffset.x < kScreenWidth) {
        [self pre];
    } else {
        [self next];
    }
}

@end
