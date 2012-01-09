//
//  PHAppDelegate.h
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-19.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHViewController;

@interface PHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PHViewController *viewController;

@end
