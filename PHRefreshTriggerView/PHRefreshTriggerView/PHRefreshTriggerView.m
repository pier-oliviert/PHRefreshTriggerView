//
//  PHRefreshTriggerView.m
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-20.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import "PHRefreshTriggerView.h"
#import <QuartzCore/QuartzCore.h>

@interface PHRefreshTriggerView ()

@property (nonatomic, retain, readwrite) UILabel *titleLabel;
@property (nonatomic, retain, readwrite) UIImageView *arrowView;
@property (nonatomic, retain, readwrite) UIActivityIndicatorView *activityView;

@end

@implementation PHRefreshTriggerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel     = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];

        self.arrowView      = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackArrow"]] autorelease];
        self.activityView   = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        
        self.titleLabel.textAlignment   = UITextAlignmentCenter;

        [self addSubview:self.titleLabel];
        
        [self addSubview:self.arrowView];
    }
    return self;
}


- (void)dealloc {
    self.titleLabel = nil;
    self.arrowView  = nil;
    
    [super dealloc];
}


- (void)layoutSubviews {
    self.arrowView.layer.position       = CGPointMake(30, CGRectGetMidY(self.bounds));
    self.arrowView.frame                = CGRectIntegral(self.arrowView.frame);
    self.activityView.layer.position    = CGPointMake(30, CGRectGetMidY(self.bounds));
    self.titleLabel.frame               = CGRectIntegral(CGRectMake(0, 4, CGRectGetWidth(self.bounds), 30));
}

#pragma mark - Synthesizers
@synthesize titleLabel      = _titleLabel;
@synthesize activityView    = _activityView;
@synthesize arrowView       = _arrowView;
@end
