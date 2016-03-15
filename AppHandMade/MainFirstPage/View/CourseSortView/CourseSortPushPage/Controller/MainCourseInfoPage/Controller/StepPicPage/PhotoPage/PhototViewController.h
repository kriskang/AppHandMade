//
//  PhototViewController.h
//  AppHandMade
//
//  Created by Kris on 15/11/17.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseViewController.h"
@protocol PassValue<NSObject>
- (void)passValue:(NSInteger)x;
@end

@interface PhototViewController : BaseViewController
@property (nonatomic, retain) NSMutableArray *photoArray;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, assign) id<PassValue> delegate;
@end
