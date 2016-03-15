//
//  MainModel.h
//  AppHandMade
//
//  Created by Kris on 15/11/10.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import "BaseModel.h"

@interface MainModel : BaseModel
@property (nonatomic, retain) NSArray *slide;
@property (nonatomic, retain) NSMutableArray *gcate;
@property (nonatomic, retain) NSMutableDictionary *relations;
@property (nonatomic, retain)  NSMutableDictionary *daren;
@property (nonatomic, retain) NSMutableArray *topic;
@property (nonatomic, retain) NSMutableArray *course;
@end
