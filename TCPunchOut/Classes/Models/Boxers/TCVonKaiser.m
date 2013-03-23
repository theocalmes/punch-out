//
//  TCVonKaiser.m
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCVonKaiser.h"
#import "TCBoxerAction.h"

static NSString * const BoxerName = @"vonkaiser";

@interface TCVonKaiser ()
@property (strong, nonatomic) TCBoxerAction *blockBodyAction;
@property (strong, nonatomic) TCBoxerAction *blockFaceAction;
@property (strong, nonatomic) TCBoxerAction *bodyHitAction;
@property (strong, nonatomic) TCBoxerAction *leftFaceHitAction;
@property (strong, nonatomic) TCBoxerAction *rightFaceHitAction;

@property (strong, nonatomic) TCBoxerAction *preJabAction;
@property (strong, nonatomic) TCBoxerAction *jabAction;
@property (strong, nonatomic) TCBoxerAction *postJabAction;
@property (strong, nonatomic) TCBoxerAction *postJabReturnAction;

@end

@implementation TCVonKaiser

- (id)init
{
    self = [super init];
    if (self) {
        TCBoxerAction *tempIdleAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_idle_g0" frameNumbers:@[@0,@1,@2] delay:1.0/6.0 boxerState:kBoxerActionStateIdle];
        [tempIdleAction repeatForeverAction];
        self.idleAction = tempIdleAction;

        [self setupJabAction];
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
    self.preJabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_preJab_g0" frameNumbers:@[@0,@1,@0,@1] delay:1.0/24.0 boxerState:kBoxerActionStatePreJab];
    [self.preJabAction sequenceWithTarget:self callback:@selector(jab)];

    self.jabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_jab_g1" frameNumbers:@[@0,@1,@2] delay:1.0/12.0 boxerState:kBoxerActionStateJab];
    [self.jabAction sequenceWithTarget:self callback:@selector(postJab)];

    self.postJabAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_postJab_g0" frameNumbers:@[@0] delay:1.0/6.0 boxerState:kBoxerActionStatePostJab];
    self.postJabAction.attackState = kBoxerAttackBody;
    [self.postJabAction moveByAmount:ccp(-5,-20) target:self callback:@selector(postJabReturn)];

    self.postJabReturnAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_postJab_g0" frameNumbers:@[@0] delay:1.0/6.0 boxerState:kBoxerActionStatePostJabReturn];
    [self.postJabReturnAction moveByAmount:ccp(0,0) target:self callback:@selector(idle)];
}

- (void)setupAttackResponseActions
{
    self.blockBodyAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_blockDown_g0" frameNumbers:@[@0, @1] delay:1.0/6.0 boxerState:kBoxerActionStateBlocking];
    [self.blockBodyAction sequenceWithTarget:self callback:@selector(idle)];

    self.blockFaceAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_blockUp_g1" frameNumbers:@[@0, @1] delay:1.0/6.0 boxerState:kBoxerActionStateBlocking];
    [self.blockFaceAction sequenceWithTarget:self callback:@selector(idle)];

    self.bodyHitAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_hitBody_g1" frameNumbers:@[@0, @0] delay:1.0/6.0 boxerState:kBoxerActionStateBodyHit];
    [self.bodyHitAction sequenceWithTarget:self callback:@selector(idle)];

    self.leftFaceHitAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_hitLeft_g0" frameNumbers:@[@0, @0] delay:1.0/6.0 boxerState:kBoxerActionStateHeadHit];
    [self.leftFaceHitAction sequenceWithTarget:self callback:@selector(idle)];

    self.rightFaceHitAction = [[TCBoxerAction alloc] initWithBaseName:@"vonkaiser_hitRight_g0" frameNumbers:@[@0, @0] delay:1.0/6.0 boxerState:kBoxerActionStateHeadHit];
    [self.rightFaceHitAction sequenceWithTarget:self callback:@selector(idle)];

}

#pragma mark - Public Transition Methods

- (void)idle
{
    self.position = self.ringPosition;
     
    if (self.actionState != kBoxerActionStateIdle)
        [self proccessAction:self.idleAction];
}

- (void)startJab
{
    if (self.actionState == kBoxerActionStateIdle)
        [self proccessAction:self.preJabAction];
}

#pragma mark - Private Transition Methods

- (void)blockBody
{
    if (self.actionState != kBoxerActionStateBlocking)
        [self proccessAction:self.blockBodyAction];
}

- (void)blockFace
{
    if (self.actionState != kBoxerActionStateBlocking)
        [self proccessAction:self.blockFaceAction];
}

- (void)bodyHit
{
    if (self.actionState != kBoxerActionStateHeadHit || self.actionState != kBoxerActionStateBodyHit)
        [self proccessAction:self.bodyHitAction];
}

- (void)leftFaceHit
{
    if (self.actionState != kBoxerActionStateHeadHit || self.actionState != kBoxerActionStateBodyHit)
        [self proccessAction:self.leftFaceHitAction];
}

- (void)rightFaceHit
{
    if (self.actionState != kBoxerActionStateHeadHit || self.actionState != kBoxerActionStateBodyHit)
        [self proccessAction:self.rightFaceHitAction];
}

- (void)jab
{
    if (self.actionState == kBoxerActionStatePreJab)
        [self proccessAction:self.jabAction];
}

- (void)postJab
{
    if (self.actionState == kBoxerActionStateJab) {
        [self proccessAction:self.postJabAction];
    }
}

- (void)postJabReturn
{
    if (self.actionState == kBoxerActionStatePostJab) {
        [self proccessAction:self.postJabReturnAction];
    }
}

@end
