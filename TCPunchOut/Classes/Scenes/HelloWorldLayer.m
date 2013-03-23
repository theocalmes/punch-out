//
//  HelloWorldLayer.m
//  TCPunchOut
//
//  Created by theo on 3/19/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

#import "TCVonKaiser.h"
#import "TCHero.h"
#import "CCTouchDispatcher.h"

@interface HelloWorldLayer ()
{
    TCVonKaiser *vonKaiser;
    TCHero *littlemac;
    CCLabelTTF *_label;
}
@end

// HelloWorldLayer implementation
@implementation HelloWorldLayer
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];

	// add layer as a child to scene
	[scene addChild: layer];

	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {

        self.isTouchEnabled = YES;

        CGSize winSize = [[CCDirector sharedDirector] winSize];

        CCSprite* background = [CCSprite spriteWithFile:@"ring.png"];
        background.tag = 1;
        background.scaleX = 3;
        background.scaleY = 3;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];


        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"vonkaiser.plist"];
        CCSpriteBatchNode *_batchNode = [CCSpriteBatchNode batchNodeWithFile:@"vonkaiser.png"];
        [self addChild:_batchNode];

        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"littlemac.plist"];
        CCSpriteBatchNode *_batchNode2 = [CCSpriteBatchNode batchNodeWithFile:@"littlemac.png"];
        [self addChild:_batchNode2];

        vonKaiser = [[TCVonKaiser alloc] init];
        vonKaiser.actionState = 0;
        vonKaiser.position = ccp(200, 150);
        vonKaiser.ringPosition = vonKaiser.position;
        vonKaiser.scaleX = 3;
        vonKaiser.scaleY = 3;
        [vonKaiser idle];
        [self addChild:vonKaiser];

        littlemac = [[TCHero alloc] init];
        littlemac.actionState = 0;
        littlemac.position = ccp(190, 100);
        littlemac.ringPosition = littlemac.position;
        littlemac.scaleX = 3;
        littlemac.scaleY = 3;
        [littlemac idle];
        [self addChild:littlemac];

        [self schedule:@selector(nextFrame:)];

        _label = [[CCLabelTTF labelWithString:@"Last button: None"
                                   dimensions:CGSizeMake(320, 50) alignment:UITextAlignmentCenter
                                     fontName:@"Arial" fontSize:32.0] retain];
        _label.position = ccp(200, 20);
        [self addChild:_label];

        // Standard method to create a button
        CCMenuItem *upperCutLeft = [CCMenuItemImage
                                    itemFromNormalImage:@"Button1.png" selectedImage:@"Button1Sel.png"
                                    target:self selector:@selector(upperCutLeftButtonTapped:)];
        upperCutLeft.position = ccp(60, 140);
        upperCutLeft.scale = 2;

        CCMenuItem *upperCutRight = [CCMenuItemImage
                                itemFromNormalImage:@"Button1.png" selectedImage:@"Button1Sel.png"
                                target:self selector:@selector(upperCutRightButtonTapped:)];
        upperCutRight.position = ccp(winSize.width - 60, 140);
        upperCutRight.scale = 2;

        CCMenuItem *jabRight = [CCMenuItemImage
                                     itemFromNormalImage:@"Button2.png" selectedImage:@"Button2Sel.png"
                                     target:self selector:@selector(jabRightButtonTapped:)];
        jabRight.position = ccp(winSize.width - 60, 80);
        jabRight.scale = 2;

        CCMenuItem *jabLeft = [CCMenuItemImage
                                itemFromNormalImage:@"Button2.png" selectedImage:@"Button2Sel.png"
                                target:self selector:@selector(jabLeftButtonTapped:)];
        jabLeft.position = ccp(60, 80);
        jabLeft.scale = 2;

        CCMenu *menu = [CCMenu menuWithItems:upperCutLeft, upperCutRight, jabRight, jabLeft, nil];
        menu.position = CGPointZero;
        [self addChild:menu];
	}
	return self;
}

- (void)upperCutLeftButtonTapped:(id)sender
{
    //[vonKaiser respondToAttack:kHeroAttackLeftUpper];
    _label.string = @"Left Upper";
    [littlemac leftUpper];
}

- (void)upperCutRightButtonTapped:(id)sender
{
    //[vonKaiser respondToAttack:kHeroAttackRightUpper];
    _label.string = @"Right Upper";
    [littlemac rightUpper];
}

- (void)jabRightButtonTapped:(id)sender
{
    //[vonKaiser respondToAttack:kHeroAttackRightJab];
    [littlemac rightJab];
    _label.string = @"Right Jab";
}

- (void)jabLeftButtonTapped:(id)sender
{
    //[vonKaiser respondToAttack:kHeroAttackLeftJab];
    [littlemac leftJab];
    _label.string = @"Left Jab";
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];

    //NSLog(@"called");
    //[vonKaiser respondToAttack:kHeroAttackRightJab];
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)nextFrame:(ccTime)dt
{
    [littlemac respondToAttack:vonKaiser.attackState];
    [vonKaiser respondToAttack:littlemac.attackState];
    if (vonKaiser.actionState == kBoxerActionStateIdle) {
        if (arc4random()%100 > 95) {
            [vonKaiser startJab];
        } else {
            [vonKaiser idle];
        }
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)

	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
