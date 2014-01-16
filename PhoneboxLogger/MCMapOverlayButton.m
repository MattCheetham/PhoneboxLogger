//
//  MCMapOverlayButton.m
//  PhoneboxLogger
//
//  Created by Matthew Cheetham on 16/01/2014.
//  Copyright (c) 2014 Matthew Cheetham. All rights reserved.
//

#import "MCMapOverlayButton.h"

@implementation MCMapOverlayButton

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.layer.cornerRadius = 17;
        self.layer.borderWidth = 1.0;
        self.alpha = 0.8;
        self.showsTouchWhenHighlighted = YES;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
    }
    
    return self;
    
}


@end
