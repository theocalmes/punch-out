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
#import "CCTouchDispatcher.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

TCVonKaiser *vonKaiser;

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

        CCSprite* background = [CCSprite spriteWithFile:@"ring.png"];
        background.tag = 1;
        background.scaleX = 3;
        background.scaleY = 3;
        background.anchorPoint = CGPointMake(0, 0);
        [self addChild:background];


        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"vonkaiser.plist"];
        CCSpriteBatchNode *_batchNode = [CCSpriteBatchNode batchNodeWithFile:@"vonkaiser.png"];
        [self addChild:_batchNode];

        NSLog(@"CACHE %@", [[CCSpriteFrameCache sharedSpriteFrameCache] description]);
        NSLog(@"HERE");

        vonKaiser = [[TCVonKaiser alloc] init];
        vonKaiser.actionState = kActionStateNone;
        vonKaiser.position = ccp(200, 200);
        vonKaiser.scaleX = 3;
        vonKaiser.scaleY = 3;
        [vonKaiser idle];

        [self addChild:vonKaiser];

        [self schedule:@selector(nextFrame:)];
	}
	return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];

    NSLog(@"called");
    [vonKaiser respondToUpper];
}

- (void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (void)nextFrame:(ccTime)dt
{
    //NSLog(@"dt:%F", dt);
    if (vonKaiser.actionState == kActionStateIdle) {
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
