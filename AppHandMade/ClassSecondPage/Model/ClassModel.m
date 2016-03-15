//
//  ClassModel.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel
- (void)dealloc
{
    [_subject release];
    [_class_image release];
    [_cid release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
