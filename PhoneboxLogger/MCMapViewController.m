//
//  MCMapViewController.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCMapViewController.h"
#import "MCPhoneboxMapView.h"

@interface MCMapViewController ()

@property (nonatomic, strong) MCPhoneboxMapView *mapView;

@end

@implementation MCMapViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.mapView = [MCPhoneboxMapView new];
        [self.mapView.addPhoneBoxButton addTarget:self action:@selector(registerLocation) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.mapView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Track user location on map
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
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

- (void)registerLocation
{
    NSLog(@"Soon!");
}

@end
