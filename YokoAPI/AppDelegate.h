//
//  AppDelegate.h
//  YokoAPI
//
//  Created by Devangi on 6/7/14.
//  Copyright (c) 2013 Devangi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate>
{
    UINavigationController *nav;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;

@end
