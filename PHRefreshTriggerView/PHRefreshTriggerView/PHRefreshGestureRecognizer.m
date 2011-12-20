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

@interface PHRefreshGestureRecognizer ()

- (BOOL)updateState:(PHRefreshState)state; //Return YES if it changed it.

@property (nonatomic, retain, readwrite) PHRefreshTriggerView *triggerView;

@end

@implementation PHRefreshGestureRecognizer
#pragma mark - Life Cycle
- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    
    if (self) {
        self.triggerView = [[[PHRefreshTriggerView alloc] initWithFrame:CGRectZero] autorelease];
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
        switch (refreshState) {
            case PHRefreshTriggered:
                //animate
                break;
            case PHRefreshIdle:
                if (self->_refreshState == PHRefreshLoading) {
                    self.scrollView.contentInset = UIEdgeInsetsMake(0,
                                                                    self.scrollView.contentInset.left,
                                                                    self.scrollView.contentInset.bottom,
                                                                    self.scrollView.contentInset.right);                    
                } else if (self->_refreshState == PHRefreshTriggered) {
                    //Animate
                }
                break;
            case PHRefreshLoading:
                self.scrollView.contentInset = UIEdgeInsetsMake(60,
                                                                self.scrollView.contentInset.left,
                                                                self.scrollView.contentInset.bottom,
                                                                self.scrollView.contentInset.right);
                // Change to spinnger and stuff...
                break;
        }
        
        self->_refreshState = refreshState;
    }
}

- (CABasicAnimation *)triggeredAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithDouble:M_PI];
    
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
        self.triggerView.frame = CGRectMake(0, -60, CGRectGetWidth(self.view.frame), 60);
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
        if (self.scrollView.contentOffset.y < -60) {
            self.refreshState   = PHRefreshTriggered;
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
