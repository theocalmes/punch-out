//
//  TCBoxerAction.m
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCBoxerAction.h"
#import "cocos2d.h"

@implementation TCBoxerAction

- (id)initWithBaseName:(NSString *)baseName frameNumbers:(NSArray *)numbers delay:(CGFloat)delay boxerState:(NSInteger)state
{
    self = [super init];
    if (self) {
        NSArray *attributes = [baseName componentsSeparatedByString:@"_"];
        NSLog(@"attributes %@", attributes);
        if (attributes.count >= 2)
            [self setupStateFromAttribute:attributes[2]];
        else
            _defenseState = kDefenseNone;

        NSLog(@"self,defensSTate = %d", _defenseState);
        CCArray *frames = [CCArray arrayWithCapacity:numbers.count];
        for (NSNumber *i in numbers) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"%@_%02d.png", baseName, i.integerValue]];
            [frames addObject:frame];
        }
        _annimation = [CCAnimation animationWithFrames:[frames getNSArray] delay:delay];
        _boxerState = state;
    }
    return self;
}

- (void)repeatForeverAction
{
    if (self.annimation) {
        self.action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.annimation]];
    }
}

- (void)sequenceActionWithTarget:(id)target callback:(SEL)callback
{
    if (self.annimation) {
        self.action = [CCSequence actions:[CCAnimate actionWithAnimation:self.annimation], [CCCallFunc actionWithTarget:target selector:callback], nil];
    }
}

- (void)setupStateFromAttribute:(NSString *)attribute
{
    if ([attribute isEqualToString:@"g0"])
        self.defenseState = kDefenseGaurdDown;
    else if ([attribute isEqualToString:@"g1"])
        self.defenseState = kDefenseGaurdUp;
    else if ([attribute isEqualToString:@"d0"])
        self.defenseState = kDefenseDodgeDown;
    else if ([attribute isEqualToString:@"d1"])
        self.defenseState = kDefenseDodgeUp;
    else
        self.defenseState = kDefenseNone;
}

@end
