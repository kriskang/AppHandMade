//
//  LeadViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/25.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *page;
@property (nonatomic, retain) UIImageView *image;

@end

@implementation LeadViewController
- (void)dealloc
{
    [_scrollView release];
    [_page release];
    [_image release];
    Block_release(_leadBlock);
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSUserDefaults standardUserDefaults] setObject:@"first" forKey:@"lead"];
    [self createScrollView];
}
- (void)createScrollView
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 5, 0);
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    [_scrollView release];
    
    NSArray *arr = @[@"yindao1", @"yindao2", @"yindao3"];
    
    for (int i=0; i<arr.count; i++) {
        UIImageView *picImageView=[[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        picImageView.image=[UIImage imageNamed:arr[i]];
        [self.scrollView addSubview:picImageView];
        [picImageView release];
    }
    
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, [UIScreen mainScreen].bounds.size.width, 10)];
    self.page.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    [self.view addSubview:self.page];
    self.page.numberOfPages = 3;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x >= [UIScreen mainScreen].bounds.size.width * 3) {
        self.leadBlock();
    }
    self.page.currentPage = self.scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
