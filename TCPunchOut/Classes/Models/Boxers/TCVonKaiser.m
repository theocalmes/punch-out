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
    self = [super init];
    if (self) {
        TCBoxerAction *tempIdleAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_idle_g0" frameNumbers:@[@0,@1,@2] delay:1.0/6.0 boxerState:kActionStateIdle];
        [tempIdleAction repeatForeverAction];
        self.idleAction = tempIdleAction;

        [self setupJabAction];
    }
    return self;
}

- (void)respondToAttack:(HeroAttackState)attack
{
    if (attack == kActionStateNone) return;

    switch (self.defenseState) {
        case kDefenseGaurdDown:
            switch (attack) {
                case kAttackLeftJab:
                case kAttackRightJab:
                    // Block
                    break;
                case kAttackLeftUpper:
                    // Hit left
                    break;
                case kAttackRightUpper:
                    // Hit right
                    break;
                default:
                    break;
            }
            break;
        case kDefenseGaurdUp:
            switch (attack) {
                case kAttackLeftJab:
                case kAttackRightJab:
                    // Hit body
                    break;
                case kAttackRightUpper:
                case kAttackLeftUpper:
                    // Block
                    break;
                default:
                    break;
            }
        case kDefenseDodgeDown:
            switch (attack) {
                case kAttackLeftJab:
                case kAttackRightJab:
                    // Hit body
                    break;
                default:
                    break;
            }
        default:
            break;
    }
}

#pragma mark - Utility Methods

- (void)proccessAction:(TCBoxerAction *)boxerAction
{
    [self stopAllActions];
    [self runAction:boxerAction.action];
    self.actionState = boxerAction.boxerState;
    self.defenseState = boxerAction.defenseState;
}

#pragma mark - Actions

- (void)setupJabAction
{
    TCBoxerAction *preJabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_preJab_g0" frameNumbers:@[@0,@1,@0,@1] delay:1.0/24.0 boxerState:kActionStatePreJab];
    [preJabAction sequenceActionWithTarget:self callback:@selector(jab)];
    self.preJabAction = preJabAction;

    TCBoxerAction *jabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_jab_g1" frameNumbers:@[@0,@1,@2] delay:1.0/2.0 boxerState:kActionStateJab];
    [jabAction sequenceActionWithTarget:self callback:@selector(postJab)];
    self.jabAction = jabAction;

    TCBoxerAction *postJabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_postJab_g0" frameNumbers:@[@0] delay:1.0/2.0 boxerState:kActionStatePostJab];
    [postJabAction sequenceActionWithTarget:self callback:@selector(idle)];
    self.postJabAction = postJabAction;
}

#pragma mark - Public Transition Methods

- (void)idle
{
    if (self.scaleX >= 3) self.scaleX = 3;
    if (self.scaleY >= 3) self.scaleY = 3;
    self.position = ccp(200, 200);
    if (self.actionState != kActionStateIdle)
        [self proccessAction:self.idleAction];
}

- (void)startJab
{
    if (self.actionState == kActionStateIdle)
        [self proccessAction:self.preJabAction];
}

#pragma mark - Private Transition Methods

- (void)jab
{
    if (self.actionState == kActionStatePreJab)
        [self proccessAction:self.jabAction];
}

- (void)postJab
{
    if (self.actionState == kActionStateJab) {
        [self proccessAction:self.postJabAction];
        self.position = ccp(self.position.x - 10, self.position.y - 25);
        self.scaleX *= 1.05;
        self.scaleY *= 1.05;
    }
}


@end
