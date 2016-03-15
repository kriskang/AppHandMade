//
//  PhototViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "PhototViewController.h"
#import "PhotoCell.h"
#import "UIImageView+WebCache.h"

@interface PhototViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@end

@implementation PhototViewController
- (void)dealloc
{
    [_photoArray release];
    [_collectionView release];
    [_flowLayout release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width,  self.view.bounds.size.height - 108)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    [_flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-108) collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    
    // 设置self.collectionView的偏移量,self.i为在MainCourseInfoViewController内记录的偏移量
    [self.collectionView setContentOffset:CGPointMake(self.i, 0)];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photoCell"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [_collectionView release];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:[[self.photoArray objectAtIndex:indexPath.item] objectForKey:@"pic"]]];
    
    //添加捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    [cell.bgImageView addGestureRecognizer:pinch];
    [pinch release];
    
    
    // 添加tap手势,目的返回MainCourseInfoViewController
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 2;
    tap.numberOfTouchesRequired = 1;
    [cell.bgImageView addGestureRecognizer:tap];
    [tap release];
    
    return cell;
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    // 把当前显示图片的偏移量传给MainCourseInfoViewController,让MainCourseInfoViewController内的collectionView(3个section的)找到其对应的偏移量
    [self.delegate passValue:self.collectionView.contentOffset.x];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    UIView *view = pinch.view;
    view.transform = CGAffineTransformScale(view.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
    NSLog(@"捏合");
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
