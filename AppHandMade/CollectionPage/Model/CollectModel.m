//
//  CollectModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/23.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel
- (void)dealloc
{
    [_userName release];
    [_userId release];
    [_faceImage release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
