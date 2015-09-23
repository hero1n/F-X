//
//  GameScene.m
//  WeDontEvenKnowThat
//
//  Created by Jaewon on 2015. 5. 8..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "GameScene.h"
#import "SecondGameScene.h"
#import "ThirdGameScene.h"
#import "FourthGameScene.h"

@implementation GameScene{
    SKNode *_player;
    SKNode *_goal;
    SKLabelNode *_timer;
    SKLabelNode *_title;
    SKScene *_scene;
    double time;
    BOOL isTouch;
    BOOL isStart;
    BOOL isEnd;
    BOOL isSuccess;
}

-(void)didMoveToView:(SKView *)view{
    static const uint32_t blockCategory = 0x1 << 0;
    static const uint32_t playerCategory = 0x1 << 1;
    
    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
    
    SKPhysicsBody *border = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    border.friction = 0;
    self.physicsBody = border;
    
    _title = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    
    _title.text = @"공을 밀어라!";
    _title.fontSize = 50;
    _title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 250);
    
    [self addChild:_title];
    
    self.scaleMode = SKSceneScaleModeAspectFill;
    
    _player = [SKNode node];
    SKShapeNode *circle = [SKShapeNode node];
    circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-40,0,80,80)].CGPath;
    circle.fillColor = [UIColor whiteColor];
    circle.strokeColor = [UIColor redColor];
    circle.glowWidth = 2;
    circle.name = @"player";
    
    [_player addChild:circle];
    
    _player.zPosition = 30;
    _player.position = CGPointMake(80, self.frame.size.height/2 - 100);
    _player.physicsBody.dynamic = YES;
    _player.physicsBody.usesPreciseCollisionDetection = YES;
    _player.physicsBody.friction = 0;
    _player.physicsBody.restitution = 1;
    _player.physicsBody.linearDamping = 0;
    _player.physicsBody.angularDamping = 0;
    _player.physicsBody.categoryBitMask = playerCategory;
    _player.physicsBody.collisionBitMask = blockCategory;
    
    //[self addChild:_player];
    
    time = 4.0;
    isStart = true;
    
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
/*
-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        static const uint32_t blockCategory = 0x1 << 0;
        static const uint32_t playerCategory = 0x1 << 1;
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        title.text = @"We don't even know that";
        title.fontSize = 50;
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) +250);
        
        [self addChild:title];
        
        _player = [SKNode node];
        SKShapeNode *circle = [SKShapeNode node];
        circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-80,-80,80,80)].CGPath;
        circle.fillColor = [UIColor whiteColor];
        circle.strokeColor = [UIColor redColor];
        circle.glowWidth = 2;
        circle.name = @"player";
        [_player addChild:circle];
        _player.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _player.physicsBody.dynamic = YES;
        _player.physicsBody.usesPreciseCollisionDetection = YES;
        _player.physicsBody.friction = 0;
        _player.physicsBody.categoryBitMask = playerCategory;
        _player.physicsBody.collisionBitMask = blockCategory;
        
        [self addChild:_player];
        
        time = 3.0;
        isStart = false;
        
        _timer = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        _timer.text = [NSString stringWithFormat:@"%.0f",time];
        _timer.fontSize = 70;
        _timer.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        
        [self addChild:_timer];
        

        
        SKAction *wait = [SKAction waitForDuration:1];
        SKAction *selector = [SKAction performSelector:@selector(gameStart) onTarget:self];
        SKAction *sequence = [SKAction sequence:@[wait,selector]];
        SKAction *repeat = [SKAction repeatActionForever:sequence];
        
        [self runAction:repeat];
    }
    return self;
}
 */

-(void)timer{
    if(time <= 0.1){
        isEnd = true;
        if(isSuccess){
            _timer.text = @"성공!";
        }else{
            _timer.text = @"실패!";
        }
        _timer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 300);
        
        SKAction *upToMid = [SKAction moveToY:CGRectGetMidY(self.frame) - 10 duration:0.25];
        upToMid.timingMode = SKActionTimingEaseOut;
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
    isSuccess = false;
    isStart = true;
    [self addChild:_player];

    _goal = [SKNode node];
    
    SKShapeNode *rect = [SKShapeNode node];
    rect.path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 80,self.frame.size.height)].CGPath;
    rect.fillColor = [UIColor redColor];
    rect.name = @"goal";
    [_goal addChild:rect];
    _goal.position = CGPointMake(self.frame.size.width - 80, 0);
    
    [self addChild:_goal];
    
    SKAction *wait = [SKAction waitForDuration:0.1];
    SKAction *selector = [SKAction performSelector:@selector(timer) onTarget:self];
    SKAction *sequence = [SKAction sequence:@[wait,selector]];
    SKAction *repeat = [SKAction repeatActionForever:sequence];
    
    [self runAction:repeat];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if([node.name isEqual:@"player"] && isStart == true){
        isTouch = true;
    }
    //[self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if(isTouch == true && isEnd == false){
        CGPoint temp = _player.position;
        temp.x = location.x;
        _player.position = temp;
    }
    
    if(_player.position.x > self.frame.size.width - 40){
        isSuccess = true;
        time = 0.1;
        
        CGPoint temp = _player.position;
        temp.x = self.frame.size.width - 40;
        _player.position = temp;
    }
    
    //if(location.x < 40) location.x = 40;
    //if(location.x < 40) location.x = 40;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
}

-(void)update:(CFTimeInterval)currentTime {
    
}

@end
