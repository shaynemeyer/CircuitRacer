//
//  GameViewController.m
//  CircuitRacer
//
//  Created by Shayne Meyer on 9/30/14.
//  Copyright (c) 2014 Maynesoft LLC. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "GameVariables.h"
#import "AnalogControl.h"

@implementation GameViewController
{
    SKView *_skView;
    AnalogControl *_analogControl;
    GameScene *_scene;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!_skView) {
        _skView = [[SKView alloc] initWithFrame:self.view.bounds];
        GameScene *scene = [[GameScene alloc] initWithSize:_skView.bounds.size
                                              carType:CRYellowCar
                                                level:CRLevelEasy];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [_skView presentScene:scene];
        [self.view addSubview:_skView];
        
        const float padSide = 128;
        const float padPadding = 10;
        
        _analogControl = [[AnalogControl alloc] initWithFrame:CGRectMake(padPadding,
                                                                         _skView.frame.size.height - padPadding - padSide,
                                                                         padSide,
                                                                         padSide)];
        [self.view addSubview:_analogControl];
        
        // add an observer to listen monitor "relativePosition" property
        [_analogControl addObserver:scene
                         forKeyPath:@"relativePosition"
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    }
}

// to prevent memory leaks remove the observer when you don't need updates anymore.
-(void)dealloc
{
    [_analogControl removeObserver:_scene forKeyPath:@"relativePosition"];
}

@end
