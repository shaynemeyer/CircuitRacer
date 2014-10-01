//
//  AnalogControl.m
//  CircuitRacer
//
//  Created by Shayne Meyer on 10/1/14.
//  Copyright (c) 2014 Maynesoft LLC. All rights reserved.
//

#import "AnalogControl.h"
#import "SKTUtils.h"

@implementation AnalogControl
{
    UIImageView *_knobImageView;
    CGPoint _baseCenter; // the neutral position for the control.
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Instruct the view to handle touches.
        [self setUserInteractionEnabled:YES];
        
        // create an image view out of base.png and make it fit the control's frame.
        UIImageView *baseImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        baseImageView.contentMode = UIViewContentModeScaleAspectFit;
        baseImageView.image = [UIImage imageNamed:@"base.png"];
        [self addSubview:baseImageView];
        
        // Calculate the center of the control's frame - this will be the "neutral" position for the knob.
        _baseCenter = CGPointMake(frame.size.width / 2, frame.size.height / 2);
        
        // Create an image view out of knob.png and position it neutrally.
        _knobImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"knob.png"]];
        _knobImageView.center = _baseCenter;
        [self addSubview:_knobImageView];
        
        // Check if the control's bounding box contains the whole knob, to ensure the knob fits the base image.
        NSAssert(CGRectContainsRect(self.bounds, _knobImageView.bounds),
                 @"Analog control size should be greater than the knob size");
        
    }
    
    return self;
}


@end
