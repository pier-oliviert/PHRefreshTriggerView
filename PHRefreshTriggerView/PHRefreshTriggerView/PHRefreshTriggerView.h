//
//  PHRefreshTriggerView.h
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-20.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHRefreshTriggerView : UIView {
    UILabel                 *_titleLabel;
    UIImageView             *_arrowView;
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, retain, readonly) UILabel *titleLabel;
@property (nonatomic, retain, readonly) UIImageView *arrowView;
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityView;
@end
