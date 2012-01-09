//
//  PHViewController.m
//  PHRefreshTriggerView
//
//  Created by Pier-Olivier Thibault on 11-12-19.
//  Copyright (c) 2011 25th Avenue. All rights reserved.
//

#import "PHViewController.h"
#import "PHRefreshGestureRecognizer.h"

@implementation PHViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self->tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    [self->tableView addGestureRecognizer:[[[PHRefreshGestureRecognizer alloc] initWithTarget:self action:@selector(stateChanged:)] autorelease]];
    [self.view addSubview:self->tableView];
}

- (void)stateChanged:(UIGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        [self performSelector:@selector(resetRecognizer) withObject:nil afterDelay:2.0];
    }
}
- (void)resetRecognizer {
    [[self->tableView refreshGestureRecognizer] setRefreshState:PHRefreshIdle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
