//
//  SecondGameScene.m
//  WeDontEvenKnowThat
//
//  Created by Jaewon on 2015. 6. 2..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "GameScene.h"
#import "SecondGameScene.h"
#import "ThirdGameScene.h"
#import "FourthGameScene.h"

@implementation SecondGameScene{
    SKLabelNode *_title;
    SKLabelNode *_timer;
    SKShapeNode *circle;
    SKScene *_scene;
    double time;
    BOOL isEnd;
    BOOL isStart;
    BOOL isTouch;
    BOOL isSuccess;
}

-(void)didMoveToView:(SKView *)view{
    NSLog(@"Second Scene");
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    _title = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _title.text = @"버튼을 누르지 마세요";
    _title.fontSize = 50;
    _title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) + 250);
    
    [self addChild:_title];
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    circle = [SKShapeNode node];
    circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-400,-400,400,400)].CGPath;
    circle.fillColor = [UIColor redColor];
    circle.strokeColor = [UIColor redColor];
    circle.glowWidth = 2;
    circle.position =  CGPointMake(CGRectGetMidX(self.frame) + 200,CGRectGetMidY(self.frame) + 200);
    circle.name = @"button";
    
    time = 4.0;
    isStart = true;
    isSuccess = true;
    
    _timer = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _timer.text = [NSString stringWithFormat:@"%.1f",time];
    _timer.fontSize = 70;
    _timer.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    
    [self addChild:_timer];
    
    
    
//    SKAction *wait = [SKAction waitForDuration:1];
//    SKAction *selector = [SKAction performSelector:@selector(gameStart) onTarget:self];
//    SKAction *sequence = [SKAction sequence:@[wait,selector]];
//    SKAction *repeat = [SKAction repeatActionForever:sequence];
//    
//    [self runAction:repeat];
    
    [self gameStart];
}


-(void)timer{
    if(time <= 0.1){
        isEnd = true;
        if(isSuccess)
            _timer.text = @"성공!";
        else
            _timer.text = @"실패!";
        _timer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 300);
        
        SKAction *upToMid = [SKAction moveToY:CGRectGetMidY(self.frame) - 10 duration:0.25];
        SKAction *wait = [SKAction waitForDuration:0.5];
        //SKAction *midToDown = [SKAction moveToY:CGRectGetMidY(self.frame) - 500 duration:0.5];
        SKAction *sequence = [SKAction sequence:@[upToMid,wait]];
        [_timer runAction:sequence];
        
        SKAction *waitUntilGame = [SKAction waitForDuration:2];
        SKAction *endGame = [SKAction performSelector:@selector(presentGame) onTarget:self];
        SKAction *sequence2 = [SKAction sequence:@[waitUntilGame,endGame]];
        [self runAction:sequence2];
        
    }else{
        time -= 0.1;
        _timer.text = [NSString stringWithFormat:@"%.1f",time];
    }
}

-(void)presentGame{
    SKTransition *reveal = //[SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
    [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.25];
    
    switch(rand()%3){
        case 0:
            _scene =  [[GameScene alloc]initWithSize:self.size];
            break;
        case 1:
            _scene = [[ThirdGameScene alloc]initWithSize:self.size];
            break;
        case 2:
            _scene = [[FourthGameScene alloc]initWithSize:self.size];
            break;
    }
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:_scene transition:reveal];
}

-(void)gameStart{
        time = 4.0;
        isEnd = false;
        isStart = true;
        [self addChild:circle];
        
        SKAction *wait = [SKAction waitForDuration:0.1];
        SKAction *selector = [SKAction performSelector:@selector(timer) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[wait,selector]];
        SKAction *repeat = [SKAction repeatActionForever:sequence];
        
        [self runAction:repeat];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqual:@"button"] && isStart == true && isEnd == false){
        isSuccess = false;
        time = 0.1;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)update:(CFTimeInterval)currentTime {
    
}


@end
