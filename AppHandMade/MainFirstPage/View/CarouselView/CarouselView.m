//
//  CarouselView.m
//  AppHandMade
//
//  Created by Kris on 15/11/12.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CarouselView.h"
#import "UIImageView+WebCache.h"

@interface CarouselView () <UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *page;
@property (nonatomic, assign) int index;
@end

@implementation CarouselView

+(instancetype)carouselViewWithArray:(NSArray *)array carouselFrame:(CGRect)carouselFrame pageFrame:(CGRect)pageFrame
{
    CarouselView *carouselView = [[CarouselView alloc] initWithFrame:carouselFrame];
    [carouselView carouseViewWithArray:array carouselFrame:carouselFrame pageFrame:pageFrame];
    return [carouselView autorelease];
}

- (void)carouseViewWithArray:(NSArray *)array carouselFrame:(CGRect)carouselFrame pageFrame:(CGRect)pageFrame
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:carouselFrame];
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollView.contentSize = CGSizeMake(carouselFrame.size.width * (array.count + 2), 0);
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.scrollView addGestureRecognizer:tap];
    [tap release];
    
    [self addSubview:self.scrollView];
    [_scrollView release];
    
    
    UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,carouselFrame.size.width,carouselFrame.size.height)];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:[array lastObject]]];
    [self.scrollView addSubview:firstImageView];
    [firstImageView release];
    
    for (int i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(carouselFrame.size.width * (i + 1), 0,carouselFrame.size.width,carouselFrame.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
        [self.scrollView addSubview:imageView];
        [imageView release];
    }
    
    UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(carouselFrame.size.width * (array.count + 1), 0, carouselFrame.size.width, carouselFrame.size.height)];
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]]];
    [self.scrollView addSubview:lastImageView];
//    [self addSubview:self.scrollView];
    
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentOffset = CGPointMake(carouselFrame.size.width, 0);
    self.scrollView.delegate = self;
    
    
    self.page = [[UIPageControl alloc] initWithFrame:pageFrame];
    self.page.alpha = 1;
    self.page.numberOfPages = array.count;
    self.page.currentPage = 0;
    // page标志所在位置的颜色
    self.page.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    // 不是page标志所在位置的颜色
    self.page.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:self.page];
    [_page release];
    
    
    
    // 添加定时器
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(handleAction) userInfo:nil repeats:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.page.currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width - 1;
    if (self.scrollView.contentOffset.x <= 0) {
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * (self.scrollView.contentSize.width / self.scrollView.frame.size.width - 2), 0);
    } else if (self.scrollView.contentOffset.x >= self.scrollView.frame.size.width * (self.scrollView.contentSize.width / self.scrollView.frame.size.width - 1)) {
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    }
}

/** 定时器实现方法 */
- (void)handleAction
{
    self.index++;
    self.page.currentPage = self.index - 1;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.index, 0);
    if (self.scrollView.contentOffset.x >=self.scrollView.frame.size.width * (self.scrollView.contentSize.width / self.scrollView.frame.size.width - 1)) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        self.index = 1;
        self.page.currentPage = self.index - 1;
    }
}
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didClick)]) {
        [self.delegate didClick];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
