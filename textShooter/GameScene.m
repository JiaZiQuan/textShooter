//
//  GameScene.m
//  textShooter
//
//  Created by jiaziquan on 15-2-5.
//  Copyright (c) 2015年 TianDiXinDao. All rights reserved.
//

#import "GameScene.h"
static const uint32_t bulletCategory     =  0x00000001;
static const uint32_t monsterCategory        =  0x00000002;
static const uint32_t planeCategory          =  0x00000002;

@implementation GameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /* Setup your scene here */
        
       // 初始化物理特性
        [self initPhysics];
        
        winSize=size;
        
        NUM_OF_ENEMIES=5;
        
        NUM_OF_BULLETS=10;
        
        //保存敌机的数组
        enemyArray=[[NSMutableArray alloc] init];
        
        //保存子弹的数组
        bulletArray=[[NSMutableArray alloc] init];
//
        self.backgroundColor = [SKColor whiteColor];
        
        enemyTexture=[SKTexture textureWithImage:[UIImage imageNamed:@"Other"]];
        
        bulletTexture=[SKTexture textureWithImage:[UIImage imageNamed:@"Other"]];
        
        SKTexture* textture=[SKTexture textureWithImage:[UIImage imageNamed:@"Spaceship"]];
        sprite = [[SKSpriteNode alloc] initWithTexture:textture color:[UIColor clearColor] size:CGSizeMake(80, 70)];
        sprite.name = @"myPlane";
        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:sprite.size];
        sprite.physicsBody.categoryBitMask = planeCategory;//类别掩码
        sprite.physicsBody.collisionBitMask = 0;//触发EventListenerPhysicsContact接触事件

        sprite.physicsBody.contactTestBitMask = monsterCategory;//允许撞我与类别掩码做运算非0可以碰撞
        sprite.physicsBody.dynamic = YES;
        sprite.position = CGPointMake(80, 70);
        [self addChild:sprite];
        [self insertChild:sprite atIndex:0];
        
        //初始化敌机
        [self initEnemyPlane:NUM_OF_ENEMIES Texture:enemyTexture];
        
        //初始化子弹
        [self initbullet:NUM_OF_BULLETS Texture:bulletTexture];
        
        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        lives.fontSize = 15.0f;
        lives.fontColor = [SKColor blackColor];
        lives.name = @"LivesLabel";
        _playerLives = 10.0f;
        lives.text = [NSString stringWithFormat:@"Lives:%lu",(unsigned long)_playerLives];
        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
       // lives.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
       
        [self addChild:lives];

        SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
        level.fontSize = 15.0f;
        level.fontColor = [SKColor blackColor];
        level.name = @"LevelLabel";
        _levelNumber = 1;
        level.text = [NSString stringWithFormat:@"Level:%lu",(unsigned long)_levelNumber];
//        level.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
//        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        level.position = CGPointMake(35,500);
        [self addChild:level];
         NSLog(@"%f",self.frame.size.width);
         NSLog(@"%f",self.frame.size.height);

    }
    return self;
}
- (void)initEnemyPlane:(int)count Texture:(SKTexture*)_texture
{
    for (int i=0; i<count; i++)
    {
        SKSpriteNode* enemySprite = [[SKSpriteNode alloc] initWithTexture:_texture color:[UIColor clearColor] size:CGSizeMake(40, 35)];
        
        enemySprite.hidden = YES;
        [self addChild:enemySprite];
        enemySprite.name = @"enemyPlane";
        enemySprite.color=[UIColor redColor];
        enemySprite.physicsBody.affectedByGravity = NO;
        enemySprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemySprite.size];
        enemySprite.physicsBody.categoryBitMask = monsterCategory;
        enemySprite.physicsBody.collisionBitMask = 0;
        enemySprite.physicsBody.contactTestBitMask = bulletCategory;
        enemySprite.physicsBody.dynamic = YES;
        [enemyArray addObject:enemySprite];
        [self insertChild:enemySprite atIndex:0];
    }
    
    [self performSelector:@selector(spawnEnemy) withObject:nil afterDelay:1.0f];
    
}
- (void)initbullet:(int)count Texture:(SKTexture*)_texture
{
    for (int i=0; i<count; i++)
    {
        SKSpriteNode* bulletSprite=[[SKSpriteNode alloc] initWithTexture:_texture color:[UIColor redColor] size:CGSizeMake(10, 15)];
        bulletSprite.name = @"bullet";
        bulletSprite.physicsBody.affectedByGravity = NO;
        bulletSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bulletSprite.size];
        bulletSprite.physicsBody.categoryBitMask = bulletCategory;
        bulletSprite.physicsBody.collisionBitMask = 0;
        bulletSprite.physicsBody.contactTestBitMask = monsterCategory;
        bulletSprite.physicsBody.dynamic = YES;
        
        bulletSprite.hidden = YES;
        [self addChild:bulletSprite];
        
        bulletSprite.color=[UIColor redColor];
        [bulletArray addObject:bulletSprite];
        [self insertChild:bulletSprite atIndex:0];
    }
}
- (void)spawnEnemy
{
    SKSpriteNode* enemySprite = [[SKSpriteNode alloc] initWithTexture:enemyTexture color:[UIColor clearColor] size:CGSizeMake(40, 35)];
    enemySprite.hidden = YES;
    
    enemySprite.name = @"enemyPlane";
    enemySprite.color=[UIColor redColor];
    enemySprite.physicsBody.affectedByGravity = NO;
    enemySprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemySprite.size];
    enemySprite.physicsBody.categoryBitMask = monsterCategory;
    enemySprite.physicsBody.collisionBitMask = 0;
    enemySprite.physicsBody.contactTestBitMask = bulletCategory;
    enemySprite.physicsBody.dynamic = YES;
    enemySprite.hidden = NO;
    enemySprite.position = CGPointMake(arc4random() % (int)(winSize.width - enemySprite.size.width) + enemySprite.size.width/2 , winSize.height);
    [self addChild:enemySprite];
    [self insertChild:enemySprite atIndex:0];
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    SKAction *actionMove=[SKAction moveBy:CGVectorMake(0,-enemySprite.position.y-enemySprite.size.height) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    
    [enemySprite runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
    [self performSelector:_cmd withObject:nil afterDelay:arc4random()%3 + 1];//每隔3到4秒调用本身一次
}
-(SKSpriteNode*) getAvailableEnemySprite
{
    SKSpriteNode *result = nil;
    for (result in enemyArray)
    {
        if (result.hidden)
        {
            break;
        }
    }
    return result;
}

-(SKSpriteNode*) getAvailableBulletSprite
{
    SKSpriteNode *result = nil;
    for (result in bulletArray)
    {
        if (result.hidden)
        {
            break;
        }
    }
    return result;
}
-(CGRect) rectOfSprite:(SKSpriteNode*)_sprite
{
    return CGRectMake(_sprite.position.x - _sprite.size.width / 2,_sprite.position.y - _sprite.size.height /2,_sprite.size.width, _sprite.size.height);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    isTouchToShoot=YES;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    touchBeginPoint=location;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    if (location.y<400)
    {
        SKAction *action = [SKAction moveTo:location duration:1.2];
        //[sprite runAction:[SKAction repeatActionForever:action]];
        [sprite runAction:action];
    }
    
}


-(void)updatePlayerShooting:(SKTexture*)texture
{
    if (!isTouchToShoot)
    {
        return;
    }
    
    [self performSelector:@selector(shot:) withObject:Nil afterDelay:0.5f];
    
}

- (void)shot:(id)sender
{
    
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
    SKSpriteNode* bulletSprite=[[SKSpriteNode alloc] initWithTexture:bulletTexture color:[UIColor redColor] size:CGSizeMake(10, 15)];
    bulletSprite.name = @"bullet";
    bulletSprite.physicsBody.affectedByGravity = NO;
    bulletSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:bulletSprite.size];
    //bulletSprite.physicsBody.categoryBitMask = bulletCategory;
    bulletSprite.physicsBody.collisionBitMask = 0;
   // bulletSprite.physicsBody.contactTestBitMask = monsterCategory;
    bulletSprite.physicsBody.dynamic = YES;
    CGPoint pos = sprite.position;
    CGPoint bulletPos = CGPointMake(pos.x,pos.y + sprite.size.height/ 2 + bulletSprite.size.height);
    bulletSprite.position = bulletPos;
    bulletSprite.hidden = NO;
    [self addChild:bulletSprite];
    [self insertChild:bulletSprite atIndex:0];
    float velocity = 100.0/1.0;
    float realMoveDuration = self.size.width / velocity;
    
    NSLog(@"%lf",self.size.width);
    SKAction * actionMove = [SKAction moveBy:CGVectorMake(0,winSize.height - bulletPos.y) duration:realMoveDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    [bulletSprite runAction:[SKAction sequence:@[actionMove, actionMoveDone]]];
    
}


-(void)update:(CFTimeInterval)currentTime
{
    /* Called before each frame is rendered */
    static int tempNum=0;
    if (tempNum>20)
    {
        [self updatePlayerShooting:bulletTexture];
        tempNum=0;
    }
    tempNum++;
    
}


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"碰撞检测 %@, %@", contact.bodyA.node.name, contact.bodyB.node.name);
    //这句是我单独写出来添加导弹的
    if ([contact.bodyA.node.name isEqualToString:@"bullet"]&&[contact.bodyB.node.name isEqualToString:@"enemyPlane"])
    {
        SKSpriteNode* bullet=(SKSpriteNode *)contact.bodyA.node;
        [bullet removeFromParent];
        SKSpriteNode* enemyPlane=(SKSpriteNode *)contact.bodyB.node;
        [enemyPlane removeFromParent];
    }
    else if ([contact.bodyA.node.name isEqualToString:@"enemyPlane"]&&[contact.bodyB.node.name isEqualToString:@"bullet"])
    {
        SKSpriteNode* enemyPlane=(SKSpriteNode *)contact.bodyA.node;
        [enemyPlane removeFromParent];
        SKSpriteNode* bullet=(SKSpriteNode *)contact.bodyB.node;
        [bullet removeFromParent];
    }
    else if ([contact.bodyA.node.name isEqualToString:@"enemyPlane"]&&[contact.bodyB.node.name isEqualToString:@"myPlane"])
    {
        SKSpriteNode* enemyPlane=(SKSpriteNode *)contact.bodyA.node;
        [enemyPlane removeFromParent];
        SKSpriteNode* myPlane=(SKSpriteNode *)contact.bodyB.node;
        //[myPlane removeFromParent];
        SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.25], [SKAction fadeInWithDuration:0.25]]];
        SKAction *blinkS = [SKAction repeatAction:blink count:4];
        [myPlane runAction:blinkS];
        
        SKLabelNode *bombNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        bombNode.name = @"Bomb";
        bombNode.text = @"Bomb!!!";
        bombNode.fontSize = 24;
        bombNode.position = enemyPlane.position;
        SKAction *zoom = [SKAction scaleTo:2 duration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[zoom,remove]];
        [self addChild:bombNode];
        [bombNode runAction:moveSequence];
    }
    else if ([contact.bodyA.node.name isEqualToString:@"myPlane"]&&[contact.bodyB.node.name isEqualToString:@"enemyPlane"])
    {
        SKSpriteNode* myPlane=(SKSpriteNode *)contact.bodyA.node;
        SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.25], [SKAction fadeInWithDuration:0.25]]];
        SKAction *blinkS = [SKAction repeatAction:blink count:4];
        [myPlane runAction:blinkS];
        SKSpriteNode* enemyPlane=(SKSpriteNode *)contact.bodyB.node;
        [enemyPlane removeFromParent];
        SKLabelNode *bombNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        bombNode.name = @"Bomb";
        bombNode.text = @"Bomb!!!";
        bombNode.fontSize = 24;
        bombNode.fontColor = [SKColor redColor];
        bombNode.position = enemyPlane.position;
        SKAction *zoom = [SKAction scaleTo:2 duration:0.25];
        SKAction *remove = [SKAction removeFromParent];
        SKAction *moveSequence = [SKAction sequence:@[zoom,remove]];
        [self addChild:bombNode];
        [bombNode runAction:moveSequence];
    }
    
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    
}

-(void)newBombAtX:(CGFloat)x Y:(CGFloat)y
{
    //    SKEmitterNode *bomb=[NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"bomb" ofType:@"sks"]];
    //    bomb.position = CGPointMake(x, y);
    //    bomb.name=@"myBomb";
    //    //发送粒子到场景。
    //    bomb.targetNode = [self scene];
    //    [self addChild:bomb];
}

- (void)didSimulatePhysics{
    [self enumerateChildNodesWithName:@"enemyPlane" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y < 0) {
            [node removeFromParent];
        }
    }];
}
- (void)initPhysics
{
    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0,0);
    //    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    //    self.name=@"Scence";
    //    self.physicsBody.dynamic = YES;
}
//-(void)didMoveToView:(SKView *)view {
//    /* Setup your scene here */
//    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//    
//    myLabel.text = @"Hello, World!";
//    myLabel.fontSize = 65;
//    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                   CGRectGetMidY(self.frame));
//    
//    [self addChild:myLabel];
//}
//+ (instancetype)sceneWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber{
//    
//    return [[self alloc]initWithSize:size levelNumber:levelNumber];
//}
//-(instancetype)initWithSize:(CGSize)size{
//    
//    return [self initWithSize:size levelNumber:1];
//}
//- (instancetype)initWithSize:(CGSize)size levelNumber:(NSUInteger)levelNumber{
//    self = [super initWithSize:size];
//    
//    if (self) {
//        _levelNumber = levelNumber;
//      
//        _playerLives = 5;
//        self.backgroundColor = [SKColor yellowColor];
//        SKLabelNode *lives = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
//        lives.fontSize = 10.0f;
//        lives.fontColor = [SKColor blackColor];
//        lives.name = @"LivesLabel";
//        lives.text = [NSString stringWithFormat:@"Lives:%lu",(unsigned long)_playerLives];
//        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
//        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
//        lives.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//        [self addChild:lives];
//        SKLabelNode *level = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
//        level.fontSize = 10.0f;
//        level.fontColor = [SKColor blackColor];
//        level.name = @"LevelLabel";
//        level.text = [NSString stringWithFormat:@"Level:%lu",(unsigned long)_levelNumber];
//        lives.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
//        lives.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
//        lives.position = CGPointMake(0, self.frame.size.height);
//        [self addChild:level];
//        
//    }
//    return self;
//    
//    
//}

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
//    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
//}

//-(void)update:(CFTimeInterval)currentTime {
//    /* Called before each frame is rendered */
//}

@end
