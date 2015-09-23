//
//  FourthGameScene.m
//  F!X
//
//  Created by Jaewon on 2015. 6. 25..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "FourthGameScene.h"
#import "GameScene.h"
#import "SecondGameScene.h"
#import "ThirdGameScene.h"

@implementation FourthGameScene{
    SKLabelNode *_title;
    SKLabelNode *_timer;
    SKNode *_timeBar;
    SKShapeNode *_timeRect;
    SKScene  *_scene;
    SKNode *trash1;
    SKNode *trash2;
    SKNode *trash3;
    SKNode *_goal;
    double time;
    bool isStart;
    bool isSuccess;
    bool isEnd;
    bool isTrash1;
    bool isTrash2;
    bool isTrash3;
}

-(double)getRandX{
    double x = arc4random() % 900 + 100;
    return x;
}

-(double)getRandY{
    double y = arc4random() % 400 + 200;
    return y;
}

-(void)didMoveToView:(SKView *)view{
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    _title = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _title.text = @"쓰레기를 치워주세요";
    _title.fontSize = 50;
    _title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) + 225);
    _title.zPosition = 32;
    
    [self addChild:_title];
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    time = 4.0;
    isStart = false;
    isSuccess = false;
    
    _timer = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _timer.text = [NSString stringWithFormat:@"%.1f",time];
    _timer.fontSize = 70;
    _timer.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    _timer.name = @"timer";
    _timer.zPosition = 30;
    
    [self addChild:_timer];
    
    [self gameStart];
}

-(void)gameStart{
//    _timeRect = [SKShapeNode node];
//    _timeRect.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, 50)].CGPath;
//    _timeRect.fillColor = [UIColor greenColor];
//    
//    _timeBar = [SKNode node];
//    [_timeBar addChild:_timeRect];
//    _timeBar.position = CGPointMake(0, self.frame.size.height - 50);
//    
//    [self addChild:_timeBar];
    
    isStart = true;
    isEnd = false;
    isTrash1 = false;
    isTrash2 = false;
    isTrash3 = false;
    
    SKShapeNode *trashRect1 = [SKShapeNode node];
    trashRect1.path = [UIBezierPath bezierPathWithRect:CGRectMake(-50, -50, 100,100)].CGPath;
    trashRect1.fillColor = [UIColor blueColor];
    trashRect1.name = @"trash1";
    
    SKShapeNode *trashRect2 = [SKShapeNode node];
    trashRect2.path = [UIBezierPath bezierPathWithRect:CGRectMake(-50, -50, 100,100)].CGPath;
    trashRect2.fillColor = [UIColor greenColor];
    trashRect2.name = @"trash2";
    
    SKShapeNode *trashRect3 = [SKShapeNode node];
    trashRect3.path = [UIBezierPath bezierPathWithRect:CGRectMake(-50, -50, 100,100)].CGPath;
    trashRect3.fillColor = [UIColor redColor];
    trashRect3.name = @"trash3";
    
    SKShapeNode *goalRect = [SKShapeNode node];
    goalRect.path = [UIBezierPath bezierPathWithRect:CGRectMake(-75, -75, 150,150)].CGPath;
    goalRect.fillColor = [UIColor yellowColor];
    goalRect.name = @"goal";
    
    trash1 = [SKNode node];
    [trash1 addChild:trashRect1];
    trash1.zPosition = 30;
    trash1.position = CGPointMake([self getRandX],[self getRandY]);
    [self addChild:trash1];
    
    trash2 = [SKNode node];
    [trash2 addChild:trashRect2];
    trash2.zPosition = 30;
    trash2.position = CGPointMake([self getRandX],[self getRandY]);
    [self addChild:trash2];
    
    trash3 = [SKNode node];
    [trash3 addChild:trashRect3];
    trash3.zPosition = 30;
    trash3.position = CGPointMake([self getRandX],[self getRandY]);
    [self addChild:trash3];
    
    _goal = [SKNode node];
    [_goal addChild:goalRect];
    _goal.position = CGPointMake(self.frame.size.width / 2, 100);
    [self addChild:_goal];
    
    SKAction *wait = [SKAction waitForDuration:0.1];
    SKAction *selector = [SKAction performSelector:@selector(timer) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[wait,selector]];
    SKAction *repeat = [SKAction repeatActionForever:sequence];
    
    [self runAction:repeat];
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
            _scene = [[SecondGameScene alloc]initWithSize:self.size];
            break;
    }
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.scene.view presentScene:_scene transition:reveal];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if(isStart == true && isEnd == false){
        if([node.name isEqual:@"trash1"] && !isTrash1){
            trash1.zPosition += 1;
        }
        if([node.name isEqual:@"trash2"] && !isTrash2){
            trash2.zPosition += 1;
        }
        if([node.name isEqual:@"trash3"] && !isTrash3){
            trash3.zPosition += 1;
        }
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node;
//    if(![[self nodeAtPoint:location].name isEqual:@"timer"])
    node = [self nodeAtPoint:location];
//    NSLog(@"trash 1 : %f \n trash 2 : %f \n trash 3 : %f",trash1.zPosition,trash2.zPosition,trash3.zPosition);
    
    if(isStart == true && isEnd == false){
        if([node.name isEqual:@"trash1"] && !isTrash1 && trash1.zPosition == 31){
            trash1.position = location;
            
            if([trash1 containsPoint:_goal.position]){
                isTrash1 = true;
                [trash1 removeFromParent];
            }
        }
        if([node.name isEqual:@"trash2"] && !isTrash2 && trash2.zPosition == 31){
            trash2.position = location;
            
            if([trash2 containsPoint:_goal.position]){
                isTrash2 = true;
                [trash2 removeFromParent];
            }
        }
        if([node.name isEqual:@"trash3"] && !isTrash3 && trash3.zPosition == 31){
            trash3.position = location;
            
            if([trash3 containsPoint:_goal.position]){
                isTrash3 = true;
                [trash3 removeFromParent];
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    trash1.zPosition = 30;
    trash2.zPosition = 30;
    trash3.zPosition = 30;
}

-(void)update:(NSTimeInterval)currentTime{
    if(isTrash1 && isTrash2 && isTrash3){
        isSuccess = true;
        time = 0.1;
    }
}
@end
