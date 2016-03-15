//
//  AppDelegate.m
//  AppHandMade
//
//  Created by Kris on 15/11/9.
//  Copyright © 2015年 康雪菲 All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "ClassViewController.h"
#import "ShoppingViewController.h"
#import "UserViewController.h"
#import "HeaderBase.h"
#import "UMSocial.h"
#import "LeadViewController.h"



@interface AppDelegate ()

@property (nonatomic, retain) UITabBarController *tabBar;

@end

@implementation AppDelegate
- (void)dealloc
{
    [_tabBar release];
    [_window release];
    [super dealloc];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 友盟
    [UMSocialData setAppKey:YOUMENGKEY];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [_window release];
    
    NSString *passWord = @"no";
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:passWord forKey:@"night"];
    
    
    self.tabBar = [[UITabBarController alloc] init];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    UINavigationController *mainNavi = [[UINavigationController alloc] initWithRootViewController:mainVC];
    mainVC.title = @"教程";
    mainNavi.navigationBar.barTintColor = mainColor;
    mainNavi.tabBarItem.title = @"教程";
    mainNavi.tabBarItem.image = [UIImage imageNamed:@"jiaocheng"];
    [mainVC release];
    [mainNavi autorelease];
    
    ClassViewController *classVC = [[ClassViewController alloc] init];
    UINavigationController *classNavi = [[UINavigationController alloc] initWithRootViewController:classVC];
    classVC.title = @"课堂";
    classNavi.navigationBar.barTintColor = mainColor;
    classNavi.tabBarItem.title = @"课堂";
    classNavi.tabBarItem.image = [UIImage imageNamed:@"ketang"];
    [classVC release];
    [classNavi autorelease];
    
    ShoppingViewController *shoppingVC = [[ShoppingViewController alloc] init];
    UINavigationController *shoppingNavi = [[UINavigationController alloc] initWithRootViewController:shoppingVC];
    shoppingVC.title = @"闪购";
    shoppingNavi.navigationBar.barTintColor = mainColor;
    shoppingNavi.tabBarItem.title = @"闪购";
    shoppingNavi.tabBarItem.image = [UIImage imageNamed:@"shangou"];
    [shoppingVC release];
    [shoppingNavi autorelease];
    
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNavi = [[UINavigationController alloc]initWithRootViewController:userVC];
    userVC.title = @"我的";
    userNavi.navigationBar.barTintColor = mainColor;
    userNavi.tabBarItem.title = @"我的";
    userNavi.tabBarItem.image = [UIImage imageNamed:@"wode"];
    [userVC release];
    [userNavi autorelease];
    
    self.tabBar.viewControllers = @[mainNavi, classNavi, shoppingNavi, userNavi];
    self.window.rootViewController = self.tabBar;
    [_tabBar release];
    
  
    void (^leadBlock)() = ^(){
        self.window.rootViewController = self.tabBar;
    };
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lead"] == nil) {
        LeadViewController *lead = [[LeadViewController alloc]init];
        lead.leadBlock = leadBlock;
        self.window.rootViewController = lead;
        [lead release];
    }else{
        
        self.window.rootViewController = self.tabBar;
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
