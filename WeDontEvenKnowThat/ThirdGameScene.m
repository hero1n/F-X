//
//  ThirdGameScene.m
//  F!X
//
//  Created by Jaewon on 2015. 6. 19..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "GameScene.h"
#import "SecondGameScene.h"
#import "ThirdGameScene.h"
#import "FourthGameScene.h"

@implementation ThirdGameScene{
    SKLabelNode *_title;
    SKLabelNode *_timer;
    SKScene *_scene;
    SKNode *_goal;
    SKNode *car1;
    SKNode *car2;
    SKNode *car3;
    double time;
    bool isTouch;
    bool isStart;
    bool isEnd;
    bool isSuccess;
    bool isCar1;
    bool isCar2;
    bool isCar3;
}

-(void)didMoveToView:(SKView *)view{
//    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"game3_background"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = 0;
    [self addChild:bgImage];
    _title = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    _title.text = @"자동차를 밀어 길을 터주세요";
    _title.fontSize = 50;
    _title.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame) + 250);
    
    [self addChild:_title];
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    time = 4.0;
    isTouch = false;
    isStart = true;
    isSuccess = false;
    
    _timer = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    _timer.text = [NSString stringWithFormat:@"%.1f",time];
    _timer.fontSize = 70;
    _timer.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    _timer.zPosition = 15;
    
    [self addChild:_timer];
    
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
            _scene =  [[SecondGameScene alloc]initWithSize:self.size];
            break;
        case 1:
            _scene = [[GameScene alloc]initWithSize:self.size];
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
    isCar1 = false;
    isCar2 = false;
    isCar3 = false;
    
    car1 = [SKNode node];
    car2 = [SKNode node];
    car3 = [SKNode node];
    _goal = [SKNode node];
    
    SKSpriteNode *carRect1 = [SKSpriteNode spriteNodeWithImageNamed:@"game3_car"];
//    carRect1.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, -75, 300,150)].CGPath;
//    carRect1.fillColor = [UIColor redColor];
//    carRect1.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:CGRectMake(-150, -75, 300, 150)];
    carRect1.userInteractionEnabled = NO;
    carRect1.name = @"car1";
    
    SKSpriteNode *carRect2 = [SKSpriteNode spriteNodeWithImageNamed:@"game3_car"];
//    carRect2.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, -75, 300,150)].CGPath;
//    carRect2.fillColor = [UIColor redColor];
    carRect2.userInteractionEnabled = NO;
    carRect2.name = @"car2";
    
    SKSpriteNode *carRect3 = [SKSpriteNode spriteNodeWithImageNamed:@"game3_car"];
//    carRect3.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, -75, 300,150)].CGPath;
//    carRect3.fillColor = [UIColor redColor];
    carRect3.userInteractionEnabled = NO;
    carRect3.name = @"car3";
    
    SKShapeNode *goalRect = [SKShapeNode node];
    goalRect.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width,200)].CGPath;
    goalRect.fillColor = [UIColor yellowColor];
    goalRect.name = @"goal";
    goalRect.alpha = 0.2;
    
    _goal.position = CGPointMake(0,30);
    _goal.zPosition = 5;
    [_goal addChild:goalRect];
    [self addChild:_goal];
    
    car1.position = CGPointMake(self.frame.size.width / 2 - 400,self.frame.size.height / 2 + 75);
    car1.zPosition = 10;
    [car1 addChild:carRect1];
    
    car2.position = CGPointMake(self.frame.size.width / 2 ,self.frame.size.height / 2 + 75);
    car2.zPosition = 10;
    [car2 addChild:carRect2];

    car3.position = CGPointMake(self.frame.size.width / 2 + 400,self.frame.size.height / 2 + 75);
    car3.zPosition = 10;
    [car3 addChild:carRect3];
    
    [self addChild:car1];
    [self addChild:car2];
    [self addChild:car3];
    
    SKAction *wait = [SKAction waitForDuration:0.1];
    SKAction *selector = [SKAction performSelector:@selector(timer) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[wait,selector]];
    SKAction *repeat = [SKAction repeatActionForever:sequence];
    
//    self.myLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
//    self.myLabel.text = @"Drag this label";
//    self.myLabel.fontSize = 20;
//    self.myLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    [self addChild:self.myLabel];
    
    [self runAction:repeat];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if(isStart == true){
        isTouch = true;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    CGPoint currentPoint = [[touches anyObject] locationInNode:self];
//    CGPoint previousPoint = [[touches anyObject] previousLocationInNode:self];
//    self.deltaPoint = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if(isTouch == true && isEnd == false){
        if([node.name isEqual:@"car1"] && !isCar1){
            CGPoint temp = car1.position;
            temp.y = location.y;
            car1.position = temp;
            
            if(car1.position.y  < 180){
                isCar1 = true;
                CGPoint temp = car1.position;
                temp.y = 130;
                car1.position = temp;
            }
        }
        if([node.name isEqual:@"car2"] && !isCar2){
            CGPoint temp = car2.position;
            temp.y = location.y;
            car2.position = temp;
            
            if(car2.position.y  < 180){
                isCar2 = true;
                CGPoint temp = car2.position;
                temp.y = 130;
                car2.position = temp;
            }
        }
        if([node.name isEqual:@"car3"] && !isCar3){
            CGPoint temp = car3.position;
            temp.y = location.y;
            car3.position = temp;
            
            if(car3.position.y  < 180){
                isCar3 = true;
                CGPoint temp = car3.position;
                temp.y = 130;
                car3.position = temp;
            }
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    self.deltaPoint = CGPointZero;
}

-(void)update:(CFTimeInterval)currentTime {
//    CGPoint newPoint = CGPointMake(self.myLabel.position.x + self.deltaPoint.x, self.myLabel.position.y + self.deltaPoint.y);
//    self.myLabel.position = newPoint;
//    self.deltaPoint = CGPointZero;
//    NSLog(@"%d %d %d",isCar1,isCar2,isCar3);
    if(isCar1 && isCar2 && isCar3){
        isSuccess = true;
        time = 0.1;
    }
}


@end
