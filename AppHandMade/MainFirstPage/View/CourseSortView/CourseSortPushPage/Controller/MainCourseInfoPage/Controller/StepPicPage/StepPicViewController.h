//
//  StepPicViewController.h
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseViewController.h"

@protocol PassIndexPath <NSObject>

- (void)passIndexPath:(NSIndexPath *)indexPath;

@end

@interface StepPicViewController : BaseViewController
@property (nonatomic, retain) NSMutableArray *stepPicArray;
@property (nonatomic, assign) id<PassIndexPath> delegate;
@end
