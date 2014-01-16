//
//  MCMapViewController.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCMapViewController.h"

@interface MCMapViewController ()

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation MCMapViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.mapView = [MKMapView new];
        [self.view addSubview:self.mapView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.mapView.frame = self.view.bounds;
}

@end
