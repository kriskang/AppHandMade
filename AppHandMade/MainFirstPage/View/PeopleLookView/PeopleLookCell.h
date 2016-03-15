//
//  PeopleLookCell.h
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PeopleLookCell : BaseTableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, retain) NSMutableDictionary *relationsDic;

@property (nonatomic, copy) void(^newActivityBlock)(void);
@property (nonatomic,copy) void(^hotMaterialBlock)(void);
@property (nonatomic, copy) void(^bestHandeMadeBlock)(void);

@property (nonatomic, retain) NSString *nameStr;
@property (nonatomic, retain) NSString *timeStr;
@property (nonatomic, retain) NSString *orderStr;

@property (nonatomic, retain) NSString *cate_idStr;
@property (nonatomic, retain) NSString *pub_timeStr;
@property (nonatomic, retain) NSString *order_Str;
@end
