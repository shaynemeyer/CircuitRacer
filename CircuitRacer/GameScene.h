//
//  GameScene.h
//  CircuitRacer
//

//  Copyright (c) 2014 Maynesoft LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameVariables.h"

@interface GameScene : SKScene

- (id)initWithSize:(CGSize)size carType:(CRCarType)carType
             level:(CRLevelType)levelType;

@end
