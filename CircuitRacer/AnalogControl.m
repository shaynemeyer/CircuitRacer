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

-(void)updateKnobWithPosition:(CGPoint)position
{
    // subtract position of touch from center of joystick. This gives you the relative offset for where the touch is.
    CGPoint positionToCenter = CGPointSubtract(position, _baseCenter);
    CGPoint direction;
    
    if (CGPointEqualToPoint(positionToCenter, CGPointZero)) {
        direction = CGPointZero;
    } else {
        direction = CGPointNormalize(positionToCenter);
    }
    
    // Calculate the radius and the length of the relative offset.
    float radius = self.frame.size.width / 2;
    float length = CGPointLength(positionToCenter);
    
    // If the length is greater than the radius, then make a vector that points in the same direction but has the length of the radius instead.
    if (length > radius) {
        length = radius;
        positionToCenter = CGPointMultiplyScalar(direction, radius);
    }
    
    CGPoint relativePosition = CGPointMake(direction.x * length / radius,
                                           direction.y * length / radius);
    _knobImageView.center = CGPointAdd(_baseCenter, positionToCenter);
    self.relativePosition = relativePosition;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    [self updateKnobWithPosition:touchLocation];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];
    [self updateKnobWithPosition:touchLocation];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateKnobWithPosition:_baseCenter];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self updateKnobWithPosition:_baseCenter];
}

@end
