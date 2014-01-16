//
//  MCPhoneboxMapView.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCPhoneboxMapView.h"

@interface MCPhoneboxMapView ()

@end

@implementation MCPhoneboxMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.addPhoneBoxButton = [[MCMapOverlayButton alloc] initWithFrame:CGRectZero];
        [self.addPhoneBoxButton setTitle:@"Add telephone box" forState:UIControlStateNormal];
        [self addSubview:self.addPhoneBoxButton];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    self.addPhoneBoxButton.frame = CGRectMake(20, self.bounds.size.height - 54, self.bounds.size.width - 40, 34);
    
}
@end
