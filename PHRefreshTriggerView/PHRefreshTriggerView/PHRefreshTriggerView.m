//
//  PHRefreshTriggerView.m
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-20.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import "PHRefreshTriggerView.h"
@interface PHRefreshTriggerView ()

@property (nonatomic, retain, readwrite) UILabel *titleLabel;
@end

@implementation PHRefreshTriggerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingNone;
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)dealloc {
    self.titleLabel = nil;
    [super dealloc];
}

#pragma mark - Synthesizers
@synthesize titleLabel = _titleLabel;
@end
