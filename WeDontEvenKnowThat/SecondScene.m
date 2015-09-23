//
//  SecondScene.m
//  WeDontEvenKnowThat
//
//  Created by Jaewon on 2015. 5. 26..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "SecondScene.h"

@implementation SecondScene

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        title.text = @"We don't even know that";
        title.fontSize = 50;
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) +250);
        
        [self addChild:title];
    }
    return self;
}

@end
