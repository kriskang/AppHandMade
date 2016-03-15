//
//  HotCourseCell.h
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HotCourseCell : BaseTableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) NSMutableArray *courseArray;

@property (nonatomic, retain) NSString *hand_id;
@property (nonatomic, copy) void(^hotCourseBlock)(void);

@end
