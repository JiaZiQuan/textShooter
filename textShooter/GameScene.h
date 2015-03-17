//
//  GameScene.h
//  textShooter
//

//  Copyright (c) 2015年 TianDiXinDao. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
enum{
     kTagPalyer = 1,
};
@interface GameScene : SKScene<SKPhysicsContactDelegate>{
    
    
    SKSpriteNode *sprite;
    
    //敌机材质
    SKTexture* enemyTexture;
    NSMutableArray* enemyArray;
    
    //子弹材质
    SKTexture* bulletTexture;
    NSMutableArray* bulletArray;
    
    //敌机总数
    int NUM_OF_ENEMIES;
    //子弹总数
    int NUM_OF_BULLETS;
    
    CGSize winSize;
    
    //开始射击
    BOOL isTouchToShoot;
    
    CGPoint touchBeginPoint;

}
@property(nonatomic,assign) NSUInteger levelNumber;
@property(nonatomic,assign) NSUInteger playerLives;
@property(nonatomic,assign) BOOL finished;

//+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;
//- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber;
@end
