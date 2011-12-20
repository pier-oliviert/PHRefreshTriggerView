//
//  PHRefreshTriggerView.m
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-19.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "PHRefreshGestureRecognizer.h"

#define FLIP_ARROW_ANIMATION_TIME 0.18f
NSString * const PHRefreshGestureAnimationKey       = @"PHRefreshGestureAnimationKey";
NSString * const PHRefreshResetGestureAnimationKey  = @"PHRefreshResetGestureAnimationKey";

@interface PHRefreshGestureRecognizer ()

- (CABasicAnimation *)triggeredAnimation;
- (CABasicAnimation *)idlingAnimation;

@property (nonatomic, retain, readwrite) PHRefreshTriggerView *triggerView;

@end

@implementation PHRefreshGestureRecognizer
#pragma mark - Life Cycle
- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    
    if (self) {
        self.triggerView                    = [[[PHRefreshTriggerView alloc] initWithFrame:CGRectZero] autorelease];
        self.triggerView.titleLabel.text    = NSLocalizedString(@"Pull to refresh...", @"PHRefreshTriggerView default");

        [self addObserver:self forKeyPath:@"view" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"view"];
    self.triggerView = nil;
    [super dealloc];
}

#pragma mark - Utilities


#pragma mark - Accessories
- (void)setRefreshState:(PHRefreshState)refreshState {
    if (refreshState != self->_refreshState) {
        __block UIScrollView *bScrollView = self.scrollView;
        
        switch (refreshState) {
            case PHRefreshTriggered:
                if (![self.triggerView.arrowView.layer animationForKey:PHRefreshGestureAnimationKey]) {
                    [self.triggerView.arrowView.layer addAnimation:[self triggeredAnimation] forKey:PHRefreshGestureAnimationKey];
                }
                self.triggerView.titleLabel.text = NSLocalizedString(@"Release...", @"PHRefreshTriggerView Triggered");                
                break;
            case PHRefreshIdle:
                if (self->_refreshState == PHRefreshLoading) {
                    [UIView animateWithDuration:0.2 animations:^{
                        bScrollView.contentInset = UIEdgeInsetsMake(0,
                                                                    self.scrollView.contentInset.left,
                                                                    self.scrollView.contentInset.bottom,
                                                                    self.scrollView.contentInset.right);
                    }];
                             
                    [self.triggerView.activityView removeFromSuperview];
                    [self.triggerView.activityView stopAnimating];
                    [self.triggerView addSubview:self.triggerView.arrowView];

                } else if (self->_refreshState == PHRefreshTriggered) {
                    if ([self.triggerView.arrowView.layer animationForKey:PHRefreshGestureAnimationKey]) {
                        [self.triggerView.arrowView.layer addAnimation:[self idlingAnimation] forKey:PHRefreshResetGestureAnimationKey];
                    }
                }
                
                self.triggerView.titleLabel.text = NSLocalizedString(@"Pull to refresh...", @"PHRefreshTriggerView default");
                break;
            case PHRefreshLoading:
                [UIView animateWithDuration:0.2 animations:^{                
                    bScrollView.contentInset = UIEdgeInsetsMake(64,
                                                                self.scrollView.contentInset.left,
                                                                self.scrollView.contentInset.bottom,
                                                                self.scrollView.contentInset.right);
                }];
                self.triggerView.titleLabel.text = NSLocalizedString(@"Loading...", @"PHRefreshTriggerView loading");
                [self.triggerView.arrowView removeFromSuperview];
                [self.triggerView addSubview:self.triggerView.activityView];
                [self.triggerView.activityView startAnimating];
                
                break;
        }
        
        self->_refreshState = refreshState;
    }
}

- (CABasicAnimation *)triggeredAnimation {
    CABasicAnimation *animation     = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration              = FLIP_ARROW_ANIMATION_TIME;
    animation.toValue               = [NSNumber numberWithDouble:M_PI];
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    return animation;
}

- (CABasicAnimation *)idlingAnimation {
    CABasicAnimation *animation     = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.delegate              = self;
    animation.duration              = FLIP_ARROW_ANIMATION_TIME;
    animation.toValue               = [NSNumber numberWithDouble:0];
    animation.removedOnCompletion   = YES;
    return animation;    
}

- (UIScrollView *)scrollView {
    return (UIScrollView *)self.view;
}

#pragma mark - Key-Value Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    id obj = [object valueForKeyPath:keyPath];
    if ([obj isKindOfClass:[UIScrollView class]]) {
        self->_triggerFlags.isBoundToScrollView = YES;
        self.triggerView.frame = CGRectMake(0, -64, CGRectGetWidth(self.view.frame), 64);
        [obj addSubview:self.triggerView];
    } else {
        self->_triggerFlags.isBoundToScrollView = NO;
    }
}

#pragma mark UIGestureRecognizer
- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer {
    return NO;
}
- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer {
    return NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self->_triggerFlags.isBoundToScrollView) {
        if (self.state < UIGestureRecognizerStateBegan) {
            self.state = UIGestureRecognizerStateBegan;
        }

        if (self.scrollView.contentOffset.y < -64) {
            self.refreshState   = PHRefreshTriggered;
            self.state          = UIGestureRecognizerStateChanged;
        } else if (self.state != UIGestureRecognizerStateRecognized) {
            self.refreshState   = PHRefreshIdle;
            self.state          = UIGestureRecognizerStateChanged;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.refreshState == PHRefreshTriggered) {
        self.refreshState   = PHRefreshLoading;
        self.state          = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
}

#pragma mark - CAAnimation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.triggerView.arrowView.layer removeAllAnimations];
}

#pragma mark - Synthesizers
@synthesize triggerView     = _triggerView;
@synthesize refreshState    = _refreshState;
@end


@implementation UIScrollView (PHRefreshGestureRecognizer)

- (PHRefreshGestureRecognizer *)refreshGestureRecognizer {
    PHRefreshGestureRecognizer *refreshRecognizer = nil;
    for (PHRefreshGestureRecognizer *recognizer in self.gestureRecognizers) {
        if ([recognizer isKindOfClass:[PHRefreshGestureRecognizer class]]) {
            refreshRecognizer = recognizer;
        }
    }
    return refreshRecognizer;
}

@end
