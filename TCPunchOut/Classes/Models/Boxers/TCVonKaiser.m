//
//  TCVonKaiser.m
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCVonKaiser.h"
#import "TCBoxerAction.h"
#import "cocos2d.h"

static NSString * const BoxerName = @"vonkaiser";

@implementation TCVonKaiser

- (id)init
{
    self = [super initWithSpriteFrameName:@"vonkaiser_idle_g0_00.png"];
    if (self) {
        
        CCArray *idleFrames = [CCArray arrayWithCapacity:3];
        for (int i = 0; i < 3; i++)
        {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_idle_g0_%02d.png", BoxerName, i]];
            [idleFrames addObject:frame];
        }
        CCAnimation *idleAnimation = [CCAnimation animationWithSpriteFrames:[idleFrames getNSArray] delay:1.0/12.0];
        
        TCBoxerAction *tempIdleAction = [[TCBoxerAction alloc] init];
        tempIdleAction.defenseState = kDefenseGaurdDown;
        tempIdleAction.boxerState = kActionStateIdle;
        tempIdleAction.action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
        self.idleAction = tempIdleAction;
        
        CCArray *preJabFrames = [CCArray arrayWithCapacity:4];
        for (int i = 0; i < 4; i++)
        {
            NSLog(@"%d mod 2 = %d", i, i%2);
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_preJab_g0_%02d.png", BoxerName, i%2]];
            [preJabFrames addObject:frame];
        }
        CCAnimation *preJabAnimation = [CCAnimation animationWithSpriteFrames:[preJabFrames getNSArray] delay:1.0/12.0];
        
        TCBoxerAction *preJabAction = [[TCBoxerAction alloc] init];
        preJabAction.defenseState = kDefenseGaurdDown;
        preJabAction.boxerState = kActionStatePreJab;
        preJabAction.action = [CCSequence actions:[CCAnimate actionWithAnimation:preJabAnimation], [CCCallFunc actionWithTarget:self selector:@selector(midJab)], nil];
        self.jabAction = preJabAction;
        
    }
    return self;
}

- (void)midJab
{
    
}

- (void)postJab
{
    
}

@end
