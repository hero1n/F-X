//
//  SplashScene.m
//  F!X
//
//  Created by Jaewon on 2015. 6. 23..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "SplashScene.h"
#import "MenuScene.h"

@implementation SplashScene{
    SKSpriteNode *splash;
    double red;
    double green;
    double blue;
}

-(void)didMoveToView:(SKView *)view{
//    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1];
    self.backgroundColor = [UIColor whiteColor];
    
    splash = [SKSpriteNode spriteNodeWithImageNamed:@"splash.png"];
    splash.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    splash.xScale = 0.9;
    splash.yScale = 0.9;
    splash.alpha = 0;

    [self addChild:splash];
    
    red = 1.0;
    green = 1.0;
    blue = 1.0;
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:1.0];
    SKAction *wait = [SKAction waitForDuration:1.0];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:1.0];
    SKAction *sequence = [SKAction sequence:@[wait,fadeIn,wait,fadeOut]];
    
    SKAction *selector = [SKAction performSelector:@selector(change) onTarget:self];
    SKAction *wait2 = [SKAction waitForDuration:0.01];
    SKAction *sequence2 = [SKAction sequence:@[selector,wait2]];
    [splash runAction:sequence completion:^{
        [self runAction:[SKAction repeatAction:sequence2 count:70] completion:^{
            [self presentGame];
        }];
    }];
}

-(void)presentGame{
    SKScene *scene = [[MenuScene alloc]initWithSize:self.size];
    [self.scene.view presentScene:scene];
}

-(void)change{
    red -= 0.85 / 70;
    green -= 0.85 / 70;
    blue -= 0.7 / 70;
    self.backgroundColor = [SKColor colorWithRed:red green:green blue:blue alpha:1];
}

@end
