//
//  TCHero.m
//  TCPunchOut
//
//  Created by theo on 3/21/13.
//
//

#import "TCHero.h"
#import "TCBoxerAction.h"

@interface TCHero ()
@property (strong, nonatomic) TCBoxerAction *idleAction;

@property (strong, nonatomic) TCBoxerAction *preLeftUpperAction;
@property (strong, nonatomic) TCBoxerAction *leftUpperAction;
@property (strong, nonatomic) TCBoxerAction *postLeftUpperAction;
@property (strong, nonatomic) TCBoxerAction *preRightUpperAction;
@property (strong, nonatomic) TCBoxerAction *rightUpperAction;
@property (strong, nonatomic) TCBoxerAction *postRightUpperAction;

@property (strong, nonatomic) TCBoxerAction *preLeftJabAction;
@property (strong, nonatomic) TCBoxerAction *leftJabAction;
@property (strong, nonatomic) TCBoxerAction *postLeftJabAction;
@property (strong, nonatomic) TCBoxerAction *preRightJabAction;
@property (strong, nonatomic) TCBoxerAction *rightJabAction;
@property (strong, nonatomic) TCBoxerAction *postRightJabAction;

@property (strong, nonatomic) TCBoxerAction *dodgeRightAction;
@property (strong, nonatomic) TCBoxerAction *dodgeLeftAction;

@property (strong, nonatomic) TCBoxerAction *hitLeftAction;
@property (strong, nonatomic) TCBoxerAction *hitRightAction;

@end

@implementation TCHero

- (id)init
{
    self = [super init];
    if (self) {
        self.idleAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_idle" frameNumbers:@[@1,@0] delay:1.0/4.0 boxerState:kHeroActionStateIdle];
        [self.idleAction repeatForeverAction];

        [self setupJabAction];
        [self setupUpperAction];
        [self setupAttackResponseActions];
    }
    return self;
}

#pragma mark - Utility Methods

- (void)proccessAction:(TCBoxerAction *)boxerAction
{
    [self stopAllActions];
    [self runAction:boxerAction.action];
    self.actionState = boxerAction.boxerState;
    self.defenseState = boxerAction.defenseState;
    self.attackState = boxerAction.attackState;
}

#pragma mark - Actions

- (void)setupJabAction
{
    // Left
    self.preLeftJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabLeft"
                                                       frameNumbers:@[@0,@1]
                                                              delay:1.0/12.0
                                                         boxerState:kHeroActionStatePreLeftJab];
    [self.preLeftJabAction sequenceWithTarget:self callback:@selector(jabLeftAttack)];

    self.leftJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabLeft"
                                                    frameNumbers:@[@2]
                                                           delay:1.0/8.0
                                                      boxerState:kHeroActionStateLeftJab];
    self.leftJabAction.attackState = kHeroAttackLeftJab;
    [self.leftJabAction moveByAmount:ccp(8, 13) target:self callback:@selector(postJabLeft)];

    self.postLeftJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabLeft"
                                                        frameNumbers:@[@1,@0]
                                                               delay:1.0/12.0
                                                          boxerState:kHeroActionStatePostLeftJab];
    [self.postLeftJabAction moveByAmount:ccp(-8, -13) target:self callback:@selector(idle)];

    // Right
    self.preRightJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabRight"
                                                        frameNumbers:@[@0,@0]
                                                               delay:1.0/12.0
                                                          boxerState:kHeroActionStatePreRightJab];
    [self.preRightJabAction sequenceWithTarget:self callback:@selector(jabRightAttack)];

    self.rightJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabRight"
                                                     frameNumbers:@[@1]
                                                            delay:1.0/8
                                                       boxerState:kHeroActionStateRightJab];
    self.rightJabAction.attackState = kHeroAttackRightJab;
    [self.rightJabAction moveByAmount:ccp(5, 10) target:self callback:@selector(postJabRight)];

    self.postRightJabAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabRight"
                                                         frameNumbers:@[@0]
                                                                delay:1.0/12.0
                                                           boxerState:kHeroActionStatePostRightJab];
    [self.postRightJabAction moveByAmount:ccp(-5, -10) target:self callback:@selector(idle)];
}

- (void)setupUpperAction
{
    self.preLeftUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_upperLeft"
                                                         frameNumbers:@[@0,@1]
                                                                delay:1.0/12.0
                                                           boxerState:kHeroActionStatePreLeftUpper];
    [self.preLeftUpperAction moveByAmount:ccp(3, 12) target:self callback:@selector(upperLeftAttack)];

    self.leftUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_upperLeft"
                                                      frameNumbers:@[@2]
                                                             delay:1.0/8.0
                                                        boxerState:kHeroActionStateLeftUpper];
    self.leftUpperAction.attackState = kHeroAttackLeftUpper;
    [self.leftUpperAction moveByAmount:ccp(5, 18) target:self callback:@selector(postUpperLeft)];

    self.postLeftUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_upperLeft"
                                                        frameNumbers:@[@2, @1,@0]
                                                               delay:1.0/12.0
                                                          boxerState:kHeroActionStatePostLeftUpper];
    [self.postLeftUpperAction moveByAmount:ccp(-8, -30) target:self callback:@selector(idle)];

    // Right
    self.preRightUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabRight"
                                                          frameNumbers:@[@0,@1]
                                                                 delay:1.0/12.0
                                                            boxerState:kHeroActionStatePreRightUpper];
    [self.preRightUpperAction moveByAmount:ccp(3, 12) target:self callback:@selector(upperRightAttack)];

    self.rightUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_upperRight"
                                                       frameNumbers:@[@0]
                                                              delay:1.0/8.0
                                                         boxerState:kHeroActionStateRightUpper];
    self.rightUpperAction.attackState = kHeroAttackRightUpper;
    [self.rightUpperAction moveByAmount:ccp(5, 18) target:self callback:@selector(postUpperRight)];

    self.postRightUpperAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_jabRight"
                                                           frameNumbers:@[@"littlemac_upperRight_00.png", @1, @0]
                                                                  delay:1.0/12.0
                                                             boxerState:kHeroActionStatePostRightUpper];
    [self.postRightUpperAction moveByAmount:ccp(-8, -30) target:self callback:@selector(idle)];
}

- (void)setupAttackResponseActions
{
    self.hitRightAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_hitRight" frameNumbers:@[@0, @1, @1] delay:1.0/12.0 boxerState:kHeroActionStateHitRight];
    [self.hitRightAction moveByAmount:ccp(-8, -25) target:self callback:@selector(idle)];

    self.hitLeftAction = [[TCBoxerAction alloc] initWithBaseName:@"littlemac_hitRight" frameNumbers:@[@0, @1] delay:1.0/12.0 boxerState:kHeroActionStateHitLeft];
    [self.hitLeftAction moveByAmount:ccp(30, -10) target:self callback:@selector(idle)];
}

#pragma mark - Enemy Attack Response

- (void)respondToAttack:(BoxerAttackState)attack
{
    if (attack == kBoxerAttackNone) return;

    switch (self.defenseState) {
        case kHeroDefenseNone:
            switch (attack) {
                case kBoxerAttackBody:
                case kBoxerAttackHead:
                    [self rightHit];
                    break;
                default:
                    break;
            }
            break;
        case kHeroDefenseDodgeLeft:
            switch (attack) {
                default:
                    // dodge left
                    break;
            }
        case kHeroDefenseDodgeRight:
            switch (attack) {
                default:
                    // dodge right
                    break;
            }
        default:
            break;
    }
}

#pragma mark - Public Transition Methods

- (void)idle
{
    self.position = self.ringPosition;
    self.flipX = NO;

    if (self.actionState != kHeroActionStateIdle)
        [self proccessAction:self.idleAction];
}

- (void)leftHit
{
    if (self.actionState != kHeroActionStateHitLeft || self.actionState != kHeroActionStateHitRight) {
        self.flipX = YES;
        [self proccessAction:self.hitLeftAction];
    }
}

- (void)rightHit
{
    if (self.actionState != kHeroActionStateHitLeft || self.actionState != kHeroActionStateHitRight)
        [self proccessAction:self.hitRightAction];
}

- (void)leftJab
{
    if (self.actionState == kHeroActionStateIdle)
        [self proccessAction:self.preLeftJabAction];
}

- (void)rightJab
{
    if (self.actionState == kHeroActionStateIdle) {
        [self proccessAction:self.preRightJabAction];
    }
}

- (void)leftUpper
{
    if (self.actionState == kHeroActionStateIdle)
        [self proccessAction:self.preLeftUpperAction];
}

- (void)rightUpper
{
    if (self.actionState == kHeroActionStateIdle) {
        [self proccessAction:self.preRightUpperAction];
    }
}

#pragma mark - Private Transition Methods

- (void)jabLeftAttack
{
    if (self.actionState == kHeroActionStatePreLeftJab) {
        [self proccessAction:self.leftJabAction];
    }
}

- (void)postJabLeft
{
    if (self.actionState == kHeroActionStateLeftJab) {
        [self proccessAction:self.postLeftJabAction];
    }
}

- (void)jabRightAttack
{
    if (self.actionState == kHeroActionStatePreRightJab) {
        [self proccessAction:self.rightJabAction];
    }
}

- (void)postJabRight
{
    if (self.actionState == kHeroActionStateRightJab) {
        [self proccessAction:self.postRightJabAction];
    }
}

- (void)upperLeftAttack
{
    if (self.actionState == kHeroActionStatePreLeftUpper) {
        [self proccessAction:self.leftUpperAction];
    }
}

- (void)postUpperLeft
{
    if (self.actionState == kHeroActionStateLeftUpper) {
        [self proccessAction:self.postLeftUpperAction];
    }
}

- (void)upperRightAttack
{
    if (self.actionState == kHeroActionStatePreRightUpper) {
        [self proccessAction:self.rightUpperAction];
    }
}

- (void)postUpperRight
{
    if (self.actionState == kHeroActionStateRightUpper) {
        [self proccessAction:self.postRightUpperAction];
    }
}

@end
