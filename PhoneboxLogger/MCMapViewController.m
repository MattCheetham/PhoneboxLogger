//
//  MCMapViewController.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCMapViewController.h"
#import "MCPhoneboxMapView.h"

@interface MCMapViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) MCPhoneboxMapView *mapView;

@end

@implementation MCMapViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.mapView = [MCPhoneboxMapView new];
        [self.mapView.addPhoneBoxButton addTarget:self action:@selector(promptUserForNumber) forControlEvents:UIControlEventTouchUpInside];
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

- (void)promptUserForNumber
{
    UIAlertView *numberPrompt = [[UIAlertView alloc] initWithTitle:@"Phone number" message:@"Enter the phone number for this box" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    numberPrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *tf = [numberPrompt textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    
    [numberPrompt show];
}

#pragma mark - Box geocoding and registration

- (void)registerLocationWithNumber:(NSString *)phoneNumber
{
    [[CLGeocoder new] reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for(CLPlacemark *placemark in placemarks){
            
            if([MFMailComposeViewController canSendMail]){
                
                MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
                mailView.mailComposeDelegate = self;
                [mailView setToRecipients:@[@"sean@example.com"]];
                [mailView setSubject:@"New phonebox"];
                [mailView setMessageBody:[NSString stringWithFormat:@"Hi Sean,\n\nHere is a new Phone box for you:\n\nPhone Number: %@\n\nLocation: %@\n\nYou're welcome", phoneNumber, placemark.description] isHTML:NO];
                
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

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        NSString *boxPhoneNumber = [alertView textFieldAtIndex:0].text;
        
        [self registerLocationWithNumber:boxPhoneNumber];
        
    }
    
}

#pragma mark - Mail delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
