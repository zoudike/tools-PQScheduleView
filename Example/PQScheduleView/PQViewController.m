//
//  PQViewController.m
//  PQScheduleView
//
//  Created by zoudike on 03/18/2019.
//  Copyright (c) 2019 zoudike. All rights reserved.
//

#import "PQViewController.h"
#import <PQScheduleView/PQSchedulePorgressView.h>

@interface PQViewController ()<PQScheduleProgressDelegate>

@end

@implementation PQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self test];
}

- (void)test {
    PQSchedulePorgressView *progress = [[PQSchedulePorgressView alloc] initWithFrame:CGRectMake(100, 100, 100, 200)];
    [self.view addSubview:progress];
    [progress startProgress];
    progress.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- PQScheduleProgressDelegate

- (void)scheduleTimeout {
    NSLog(@"超时");
}

- (void)scheduleProgress:(CGFloat)progress {
    NSLog(@"进度");
}

@end
