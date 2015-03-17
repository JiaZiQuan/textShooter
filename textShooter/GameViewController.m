//
//  GameViewController.m
//  textShooter
//
//  Created by jiaziquan on 15-2-5.
//  Copyright (c) 2015年 TianDiXinDao. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation SKScene (Unarchive)

//+ (instancetype)unarchiveFromFile:(NSString *)file {
//    /* Retrieve scene file path from the application bundle */
//    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
//    /* Unarchive the file to an SKScene object */
//    NSData *data = [NSData dataWithContentsOfFile:nodePath
//                                          options:NSDataReadingMappedIfSafe
//                                            error:nil];
//    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//    [arch setClass:self forClassName:@"SKScene"];
//    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
//    [arch finishDecoding];
//    
//    return scene;
//}

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
//    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
//    /* Sprite Kit applies additional optimizations to improve rendering performance */
//    skView.ignoresSiblingOrder = YES;
//    
//    // Create and configure the scene.
//    //GameScene *scene = [GameScene unarchiveFromFile:@"GameScene"];
//    GameScene *scene = [[GameScene alloc]initWithSize:CGSizeMake(568.0f, 320.0f) levelNumber:1];
//    scene.scaleMode = SKSceneScaleModeAspectFill;
//    
//    // Present the scene.
//    [skView presentScene:scene];
    self.navigationController.navigationBarHidden=NO;
    self.title=@"游戏界面";
    SKView* view=[[SKView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
    
    GameScene* fistScence=[GameScene sceneWithSize:view.bounds.size];
    
//    NSLog(@"%f",view.bounds.size.width);
//    NSLog(@"%f",view.bounds.size.height);
//    NSLog(@"%f",view.bounds.origin.x);
//    NSLog(@"%f",view.bounds.origin.y);
    fistScence.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [view presentScene:fistScence];

}

//- (BOOL)shouldAutorotate
//{
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//        return UIInterfaceOrientationMaskAll;
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
