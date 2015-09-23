//
//  GameViewController.m
//  WeDontEvenKnowThat
//
//  Created by Jaewon on 2015. 5. 8..
//  Copyright (c) 2015년 App:ple Pi. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "SecondGameScene.h"
#import "ThirdGameScene.h"
#import "FourthGameScene.h"
#import "MenuScene.h"
#import "SplashScene.h"

@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;

    SplashScene *scene = [SplashScene unarchiveFromFile:@"GameScene"];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    [skView presentScene:scene];
    
//    // Create and configure the scene.
//    MenuScene *scene = [MenuScene unarchiveFromFile:@"GameScene"];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene.
//    [skView presentScene:scene];
    
//    GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
//    [skView presentScene:scene];
    
//    ThirdGameScene *scene = [ThirdGameScene unarchiveFromFile:@"GameScene"];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    [skView presentScene:scene];
    
//    FourthGameScene *scene = [FourthGameScene unarchiveFromFile:@"GameScene"];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
