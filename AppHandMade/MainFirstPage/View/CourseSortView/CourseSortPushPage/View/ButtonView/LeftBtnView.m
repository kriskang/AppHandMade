//
//  LeftBtnView.m
//  AppHandMade
//
//  Created by Kris on 15/11/14.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "LeftBtnView.h"
#import "BtnViewColCell.h"
#import "HeaderBase.h"

#define secondColor [UIColor colorWithRed:255/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]

@interface LeftBtnView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, retain) NSArray *nameArray;
@property (nonatomic, retain) NSArray *cate_idArray;

@end
@implementation LeftBtnView

- (void)dealloc
{
    [_collectionView release];
    [_flowLayout release];
    [_nameArray release];
    [_cate_idArray release];
    Block_release(_leftBtnBlock);
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 后三 新数据
        self.nameArray = @[@"创意手工", @"旧物改造", @"手工皮具", @"电子科技", @"美食园艺", @"手工布艺", @"粘土/陶艺", @"美容护肤", @"刺绣/编织", @"饰品DIY"];
        self.cate_idArray = @[@"&cate_id=93&gcate=cate",@"&cate_id=3&gcate=cate",@"&cate_id=52&gcate=cate",@"&cate_id=109&gcate=cate",@"&cate_id=1&gcate=cate",@"&cate_id=41&gcate=cate",@"&cate_id=74&gcate=cate",@"&cate_id=27&gcate=cate",@"&cate_id=101&gcate=cate",@"&cate_id=109&gcate=cate"];
        [self createCollectionView];
        
        // 夜间模式点击后执行
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"black" object:nil];
        //从night中取出储存的字符串(yes,day)
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        NSString *passWord = [user objectForKey:@"night"];
        //判断字符串信息
        if ([passWord isEqualToString:@"yes"]) {
            self.collectionView.backgroundColor = nightColorCell;
        }

    }
    return self;
}
- (void)changeColor:(NSNotification *)notification
{
    self.collectionView.backgroundColor = nightColor;
    //找到字符串
    NSString *passWord = [notification object];
    //判断是yes还是no,yes的话改变背景颜色
    if ([passWord isEqualToString:@"no"]) {
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    //消息中心发出消息NSUserDefaults将object中的字符串存入night中
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
}

- (void)createCollectionView
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_flowLayout release];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[BtnViewColCell class] forCellWithReuseIdentifier:@"btnViewColCell"];
    
    
    [self addSubview:self.collectionView];
    [_collectionView release];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnViewColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnViewColCell" forIndexPath:indexPath];
    cell.backgroundColor = secondColor;
    cell.titleLabel.text = self.nameArray[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.leftBtnBlock(self.nameArray[indexPath.item],self.cate_idArray[indexPath.item]);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    self.flowLayout.itemSize = CGSizeMake(170*Screen_W, 40*Screen_H);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10*Screen_H, 10*Screen_W, 10*Screen_H, 10*Screen_W);
    self.flowLayout.minimumLineSpacing = 3*Screen_H;
    self.flowLayout.minimumInteritemSpacing = 3*Screen_H;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
