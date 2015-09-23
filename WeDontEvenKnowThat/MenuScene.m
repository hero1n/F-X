//
//  MenuScene.m
//  WeDontEvenKnowThat
//
//  Created by Jaewon on 2015. 6. 12..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "MenuScene.h"
#import "SecondGameScene.h"
#import "GameScene.h"
#import "ThirdGameScene.h"

@implementation MenuScene{
    SKLabelNode *_title1;
    SKLabelNode *_title2;
    SKLabelNode *_title3;
    SKScene *_scene;
    SKLabelNode *_label;
    bool isEnd;
    SKShapeNode *_button;
}

-(void)didMoveToView:(SKView *)view{
    _title1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
    _title2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
    _title3 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Bold"];
    _label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica Neue Thin"];
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1];
    
    isEnd = false;
    
    _label.text = @"Touch screen to start";
    _label.fontSize = 100;
    _label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150);
    
    _title1.text = @"F";
    _title1.position = CGPointMake(400, CGRectGetMidY(self.frame) + 400);
    _title1.fontSize = 220;
    
    _title2.text = @"!";
    _title2.color = [UIColor whiteColor];
    _title2.colorBlendFactor = 1;
    _title2.fontSize = 220;
    _title2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 400);
    
    _title3.text = @"X";
    _title3.fontSize = 220;
    _title3.position = CGPointMake(self.frame.size.width - 400, CGRectGetMidY(self.frame) + 400);
    
    SKAction *goToPosition = [SKAction moveToY:CGRectGetMidY(self.frame) duration:0.25];
    //SKAction *goToPosition = [SKAction fadeOutWithDuration:0.5];
    SKAction *wait1 = [SKAction waitForDuration:0.5];
    SKAction *wait2 = [SKAction waitForDuration:1];
    SKAction *wait3 = [SKAction waitForDuration:1.5];
    
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:1.5];
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.2 duration:1.0];
    
    SKAction *sequence1 = [SKAction sequence:@[wait1,goToPosition]];
    SKAction *sequence2 = [SKAction sequence:@[wait2,goToPosition]];
    SKAction *sequence3 = [SKAction sequence:@[wait3,goToPosition]];
    
    SKAction *fadeSequence = [SKAction sequence:@[fadeIn,fadeOut]];
    SKAction *repeat = [SKAction repeatActionForever:fadeSequence];
    _button = [SKShapeNode node];
    
    [self addChild:_title1];
    [self addChild:_title2];
    [self addChild:_title3];
    
    [_title1 runAction:sequence1];
    [_title2 runAction:sequence2];
    /*[_title2 runAction:wait4 completion:^{
     [_title2 runAction:repeat];
     }];*/
    [_title3 runAction:sequence3 completion:^{
        [self runAction:wait2 completion:^{
            isEnd = true;
            _label.alpha = 0;
            [self addChild:_label];
            [_label runAction:repeat withKey:@"Start"];
        }];
    }];
}

-(void)presentGame{
    SKTransition *reveal = //[SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    //[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:1.0];
    [SKTransition flipVerticalWithDuration:0.75];
    switch(rand()%3){
        case 0:
            _scene =  [[SecondGameScene alloc]initWithSize:self.size];
            break;
        case 1:
            _scene = [[ThirdGameScene alloc]initWithSize:self.size];
            break;
        case 2:
            _scene = [[GameScene alloc]initWithSize:self.size];
    }
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:_scene transition:reveal];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(isEnd == true){
        SKAction *wait = [SKAction waitForDuration:1.5];
        _title2.color = [UIColor yellowColor];
        [self runAction:wait completion:^{
            [self presentGame];
        }];
        [_label removeActionForKey:@"Start"];
        _label.alpha = 1.0;
    }
}

-(void)update:(NSTimeInterval)currentTime{
}
@end
