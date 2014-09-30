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

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    SKView *skView = (SKView *)self.view;
    
    if (!skView) {
        skView =
        [[SKView alloc] initWithFrame:self.view.bounds];
        GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size
                                              carType:CRYellowCar
                                                level:CRLevelEasy];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        [skView presentScene:scene];
        [self.view addSubview:skView];
    }
}

@end
