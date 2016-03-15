//
//  DataBaseHandle.h
//  AppHandMade
//
//  Created by Kris on 15/11/23.
//  Copyright © 2015年 康雪菲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectModel.h"
#import <sqlite3.h>

@interface DataBaseHandle : NSObject
@property (nonatomic, retain) CollectModel *model;

+(instancetype)sharedDataBase;
- (void)openDB;
- (void)createTable;
- (NSMutableArray *)selectCollectWithName:(NSString *)userName;
- (void)insertCollect:(CollectModel *)model;
- (void)deleteCollectWithName:(NSString *)userName;
- (void)closeDB;
- (NSMutableArray *)selecteCollect;

@end
