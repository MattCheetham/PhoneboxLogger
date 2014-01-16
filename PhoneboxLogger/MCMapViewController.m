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
    [[CLGeocoder new] reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for(CLPlacemark *placemark in placemarks){
            
            if([MFMailComposeViewController canSendMail]){
                
                MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
                [mailView setSubject:@"New phonebox"];
                [mailView setMessageBody:[NSString stringWithFormat:@"Hi Sean,\n\nHere is a new Phone box for you:\n\n%@\n\nYou're welcome", placemark.description] isHTML:NO];
                
                [self presentViewController:mailView animated:YES completion:nil];
                
            } else {
            
                //Its good to have fallbacks if people don't have mail set up
                UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[[NSString stringWithFormat:@"Hi Sean,\n\nHere is a new Phone box for you:\n\n%@\n\nYou're welcome", placemark.description]] applicationActivities:nil];
                [self presentViewController:viewController animated:YES completion:nil];
                
            }
            
            break;
            
        }
        
        
    }];
}

@end
