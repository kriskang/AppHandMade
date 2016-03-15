//
//  MainCourseInfoViewController.m
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "MainCourseInfoViewController.h"
#import "MainCourseInfoModel.h"
#import "CourseInfoCell.h"
#import "CourseToolsCell.h"
#import "CourseStepCell.h"
#import "AFNetWorkTool.h"
#import "UIImageView+WebCache.h"
#import "StepPicViewController.h"
#import "PhototViewController.h"
#import "UMSocial.h"
#import "HeaderBase.h"


#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface MainCourseInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, PassIndexPath, PassValue, UMSocialUIDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) MainCourseInfoModel *mainCourseInfoModel;
@end

@implementation MainCourseInfoViewController
- (void)dealloc
{
    [_hand_id release];
    
    [_collectionView release];
    [_flowLayout release];
    [_mainCourseInfoModel release];
    [super dealloc];
}
/** 数据处理 */
- (void)handleData
{
    NSString *str0 = [NSString stringWithFormat:@"http://m.shougongke.com/index.php?&c=Course&a=CourseDetial&id=%@", self.hand_id];
//    NSLog(@"%@",self.hand_id);
    [AFNetWorkTool getUrlString:str0 body:nil response:JSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"-----%@", responseObject);
        NSMutableDictionary *dataDic = responseObject[@"data"];
        self.mainCourseInfoModel = [[MainCourseInfoModel alloc]init];
        [self.mainCourseInfoModel setValuesForKeysWithDictionary:dataDic];
//        NSLog(@"!!!!!%@", self.mainCourseInfoModel.subject);
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"+++++%@", error);
    }];
}

/** 创建collectionView */
- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.flowLayout setItemSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height-108)];
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
    [_flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height-108) collectionViewLayout:self.flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = secondColor;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.collectionView registerClass:[CourseInfoCell class] forCellWithReuseIdentifier:@"courseInfoCell"];
    [self.collectionView registerClass:[CourseToolsCell class] forCellWithReuseIdentifier:@"courseToolsCell"];
    [self.collectionView registerClass:[CourseStepCell class] forCellWithReuseIdentifier:@"courseStepCell"];
    
    [self.view addSubview:self.collectionView];
    [_collectionView release];
}

/** 3个section:第一,二返回一个item 第三返回步骤数个item */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 2) {
        return self.mainCourseInfoModel.step.count;
    } else {
        return 1;
    }
}
/** 返回3个section */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
/** cell重用池 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        // 课程介绍
        CourseInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseInfoCell" forIndexPath:indexPath];
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:self.mainCourseInfoModel.host_pic_m]];
        cell.subjectLabel.text = self.mainCourseInfoModel.subject;
        cell.summaryLabel.text = self.mainCourseInfoModel.summary;
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.mainCourseInfoModel.face_pic]];
        cell.userNameLabel.text = self.mainCourseInfoModel.user_name;
        cell.infoLabel.text = [NSString stringWithFormat:@"%@人气|%@收藏|%@评论|%@赞", self.mainCourseInfoModel.view, self.mainCourseInfoModel.collect, self.mainCourseInfoModel.comment_num, self.mainCourseInfoModel.laud];

        return cell;
    }
    if (indexPath.section == 1) {
        // 课程材料
        CourseToolsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseToolsCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor yellowColor];
        cell.materialArray = self.mainCourseInfoModel.material;
        cell.toolsArray = self.mainCourseInfoModel.tools;
        [cell.collectionView reloadData];
        
        return cell;
    }
    if (indexPath.section == 2) {
        // 制作步骤
        CourseStepCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"courseStepCell" forIndexPath:indexPath];
        cell.backgroundColor = secondColor;
       
        [cell.stepImageView sd_setImageWithURL:[NSURL URLWithString:[self.mainCourseInfoModel.step[indexPath.item] objectForKey:@"pic"]]];
        cell.stepLabel.text = [self.mainCourseInfoModel.step[indexPath.item] objectForKey:@"content"];
        [cell.stepBtn setTitle:[NSString stringWithFormat:@"步骤:%ld/%ld", indexPath.item + 1,self.mainCourseInfoModel.step.count] forState:UIControlStateNormal];
        
        [cell.stepBtn addTarget:self action:@selector(pushStepPicVC:) forControlEvents:UIControlEventTouchUpInside];
        
        // 直接在重用cell上添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        //需要点击多少下
        tap.numberOfTapsRequired = 2;
        //需要几个手指头
        tap.numberOfTouchesRequired = 1;
        [cell.stepImageView addGestureRecognizer:tap];
        cell.stepImageView.userInteractionEnabled = YES;
        [tap release];
        
        return cell;
    }
    return nil;
}

/** btn点击事件 实现点击步骤按钮进入stepPicVC */
- (void)pushStepPicVC:(UIButton *)button
{
    StepPicViewController *stepPicVC = [[StepPicViewController alloc]init];
    [self.navigationController pushViewController:stepPicVC animated:YES];
    stepPicVC.stepPicArray = self.mainCourseInfoModel.step;
    stepPicVC.delegate = self;
    [stepPicVC release];
}

/** StepPicViewController协议方法 点击cell时传回index(第几张)*/
- (void)passIndexPath:(NSIndexPath *)indexPath
{
    // (indexPath.item +2)为当步骤取indexPath.item时,pic偏移量 (偏移量是从section为0时第一张开始算)
    [self.collectionView setContentOffset:CGPointMake((indexPath.item +2)* self.view.bounds.size.width, 0) animated:YES];
}

/** 当轻拍步骤图片时 执行下面方法 */
- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    NSLog(@"tap");
    PhototViewController *photoVC = [[PhototViewController alloc]init];
    [self.navigationController pushViewController:photoVC animated:YES];
    photoVC.photoArray = self.mainCourseInfoModel.step;
    
    photoVC.delegate = self;

    // 当前photoVC显示的图片的偏移量为collectionView的偏移量减去前两个cell的宽度(正好为self.view的宽度)
    // 获取到当前显示的步骤图片的偏移量 间接把偏移量给到PhototViewController内部 供其内部使用(设定photoVC内collectionView显示偏移量)
    photoVC.i = self.collectionView.contentOffset.x -self.view.bounds.size.width*2;
    
    [photoVC release];
}

/** PhototViewController协议方法 x为在PhototViewController内collectionView当前显示图片的偏移量 */
- (void)passValue:(NSInteger)x
{
    // x加上前两个页面的宽度 为MaincourseVC内collectionView(3个section的)的偏移量
    [self.collectionView setContentOffset:CGPointMake(x +self.view.bounds.size.width*2, 0)];
}

- (void)shareButtonAction:(UIBarButtonItem *)item
{
#warning 写分享功能!!!  
    NSString *urlStr = self.mainCourseInfoModel.host_pic;
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];

    [UMSocialSnsService presentSnsIconSheetView:self appKey:YOUMENGKEY shareText:self.mainCourseInfoModel.subject shareImage:image shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToRenren, UMShareToDouban,nil]  delegate:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self handleData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-fenxiang"] style:UIBarButtonItemStyleDone target:self action:@selector(shareButtonAction:)];
    
    [self createCollectionView];
    
    // 夜间模式点击后执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
    //从night中取出储存的字符串(yes,day)
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [user objectForKey:@"night"];
    //判断字符串信息
    if ([passWord isEqualToString:@"yes"]) {
        
        self.collectionView.backgroundColor = nightColor;
    }

}
- (void)changeColor:(NSNotification *)notification
{
    self.collectionView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        
        self.collectionView.backgroundColor = secondColor;
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
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
