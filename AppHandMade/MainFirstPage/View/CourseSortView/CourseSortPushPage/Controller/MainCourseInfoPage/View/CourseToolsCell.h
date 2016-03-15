//
//  CourseToolsCell.h
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface CourseToolsCell : BaseCollectionViewCell
@property (nonatomic, retain) NSMutableArray *toolsArray;
@property (nonatomic, retain) NSMutableArray *materialArray;

@property (nonatomic, retain) UICollectionView *collectionView;

@end
