//
//  MainModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel
- (void)dealloc
{
    [_slide release];
    [_gcate release];
    [_relations release];
    [_daren release];
    [_topic release];
    [_course release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
