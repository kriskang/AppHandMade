//
//  UsersContentCell.h
//  AppHandMade
//
//  Created by Kris on 15/11/19.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface UsersContentCell : BaseTableViewCell
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) NSMutableArray *list;
@property (nonatomic, copy)void (^usersContentBlock) (void);
@property (nonatomic, retain) NSString *hand_idStr;
@end
