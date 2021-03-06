//
//  MCMapViewController.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCMapViewController.h"
#import "MCPhoneboxMapView.h"

@interface MCMapViewController () <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) MCPhoneboxMapView *mapView;

@end

@implementation MCMapViewController

- (id)init
{
    self = [super init];
    if (self) {

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

- (void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    self.mapView.frame = self.view.bounds;
    
}

- (void)promptUserForNumber
{
    
    UIAlertView *numberPrompt = [[UIAlertView alloc] initWithTitle:@"Phone number" message:@"Enter the phone number for this box" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    numberPrompt.alertViewStyle = UIAlertViewStylePlainTextInput;
    numberPrompt.tag = 1;
    
    UITextField *tf = [numberPrompt textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    
    [numberPrompt show];
    
}

#pragma mark - Box geocoding and registration

- (void)registerLocationWithNumber:(NSString *)phoneNumber
{
    [[CLGeocoder new] reverseGeocodeLocation:self.mapView.userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if(!error && placemarks.count){
            
            for(CLPlacemark *placemark in placemarks){
                
                NSString *boxInformationText = [NSString stringWithFormat:@"Hi Sean,\n\nHere is a new Phone box for you:\n\nPhone Number: %@\n\nLocation: %@\n\nYou're welcome", phoneNumber, placemark.description];
                
                if([MFMailComposeViewController canSendMail]){
                    
                    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
                    mailView.mailComposeDelegate = self;
                    [mailView setToRecipients:@[@"sean@example.com"]];
                    [mailView setSubject:@"New phonebox"];
                    [mailView setMessageBody:boxInformationText isHTML:NO];
                    
                    [self presentViewController:mailView animated:YES completion:nil];
                    
                } else {
                
                    //Its good to have fallbacks if people don't have mail set up
                    UIActivityViewController *viewController = [[UIActivityViewController alloc] initWithActivityItems:@[boxInformationText] applicationActivities:nil];
                    [self presentViewController:viewController animated:YES completion:nil];
                    
                }
                
                break;
                
            }
            
        } else {
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Whoops, looks like something went wrong. Please try again" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            
            [error show];
            
        }
        
        
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        
        NSString *boxPhoneNumber = [alertView textFieldAtIndex:0].text;
        
        [self registerLocationWithNumber:boxPhoneNumber];
        
    }
    
}

#pragma mark - Mail delegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if(result == MFMailComposeResultSent){
        
        UIAlertView *thankyouAlert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Sean appreciates your submission, keep it up!" delegate:self cancelButtonTitle:@"No problemo!" otherButtonTitles:nil];
        [thankyouAlert show];
        
    }
    
}

@end
