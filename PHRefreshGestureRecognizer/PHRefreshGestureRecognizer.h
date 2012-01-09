//
//  PHRefreshTriggerView.h
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-19.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHRefreshTriggerView.h"

typedef enum {
    PHRefreshIdle = 0,
    PHRefreshTriggered,
    PHRefreshLoading
} PHRefreshState;

@interface PHRefreshGestureRecognizer : UIGestureRecognizer {
    PHRefreshState          _refreshState;
    PHRefreshTriggerView    *_triggerView;

    struct {
        BOOL isBoundToScrollView:1;
    } _triggerFlags;
}

@property (nonatomic, assign) PHRefreshState refreshState; // You can force a state by modifying this value.
@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, readonly, retain) PHRefreshTriggerView *triggerView; 

@end

@interface UIScrollView (PHRefreshGestureRecognizer)
- (PHRefreshGestureRecognizer *)refreshGestureRecognizer; //Will return nil if there's no gesture attached to that scrollview
@end