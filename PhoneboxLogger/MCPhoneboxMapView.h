//
//  MCPhoneboxMapView.h
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MCMapOverlayButton.h"

@interface MCPhoneboxMapView : MKMapView

@property (nonatomic, strong) MCMapOverlayButton *addPhoneBoxButton;

@end
