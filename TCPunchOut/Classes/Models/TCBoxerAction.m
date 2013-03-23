//
//  TCAction.m
//  TCPunchOut
//
//  Created by theo on 3/22/13.
//
//

#import "TCBoxerAction.h"

@implementation TCBoxerAction

- (id)initWithBaseName:(NSString *)baseName frameNumbers:(NSArray *)numbers delay:(CGFloat)delay boxerState:(NSInteger)state
{
    self = [super init];
    if (self) {
        CCArray *frames = [CCArray arrayWithCapacity:numbers.count];
        for (id i in numbers) {
            NSString *frameName = nil;
            if ([i isKindOfClass:[NSNumber class]])
                frameName = [NSString stringWithFormat:@"%@_%02d.png", baseName, [i integerValue]];
            else
                frameName = i;

            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
            [frames addObject:frame];
        }
        _annimation = [CCAnimation animationWithSpriteFrames:[frames getNSArray] delay:delay];
        _boxerState = state;
        _defenseState = 0;
        _attackState = 0;

        [self setupStateFromName:baseName];
    }
    return self;
}

- (void)setupStateFromName:(NSString *)name
{
    if ([name rangeOfString:@"g0"].location != NSNotFound) _defenseState = kBoxerDefenseGaurdDown;
    if ([name rangeOfString:@"g1"].location != NSNotFound) _defenseState = kBoxerDefenseGaurdUp;
    if ([name rangeOfString:@"d0"].location != NSNotFound) _defenseState = kBoxerDefenseDodgeDown;
    if ([name rangeOfString:@"d1"].location != NSNotFound) _defenseState = kBoxerDefenseDodgeUp;

    if ([name rangeOfString:@"a0"].location != NSNotFound) _defenseState = kBoxerAttackBody;
    if ([name rangeOfString:@"a1"].location != NSNotFound) _defenseState = kBoxerAttackHead;
}

- (void)repeatForeverAction
{
    if (!self.annimation) return;
    self.action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.annimation]];
}

- (void)sequenceWithTarget:(id)target callback:(SEL)callback
{
    if (!self.annimation) return;
    self.action = [CCSequence actions:[CCAnimate actionWithAnimation:self.annimation], [CCCallFunc actionWithTarget:target selector:callback], nil];
}

- (void)moveByAmount:(CGPoint)amount target:(id)target callback:(SEL)callback
{
    if (!self.annimation) return;
    id moveAction = [CCMoveBy actionWithDuration:self.annimation.duration position:ccp(amount.x, amount.y)];
    id spawn = [CCSpawn actions:[CCAnimate actionWithAnimation:self.annimation], moveAction, nil];
    self.action = [CCSequence actions:spawn, [CCCallFunc actionWithTarget:target selector:callback], nil];
}

@end
