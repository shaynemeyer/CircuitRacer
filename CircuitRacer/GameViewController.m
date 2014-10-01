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


@implementation GameViewController
{
    SKView *_skView;
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
    }
}

@end
