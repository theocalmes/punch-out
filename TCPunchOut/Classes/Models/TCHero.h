//
//  TCHero.h
//  TCPunchOut
//
//  Created by theo on 3/21/13.
//
//

#import "CCSprite.h"

typedef enum {
    kHeroActionStateNone = 0,
    kHeroActionStateIdle,
    kHeroActionStatePreRightJab,
    kHeroActionStateRightJab,
    kHeroActionStatePostRightJab,
    kHeroActionStatePreLeftJab,
    kHeroActionStateLeftJab,
    kHeroActionStatePostLeftJab,
    kHeroActionStatePreLeftUpper,
    kHeroActionStateLeftUpper,
    kHeroActionStatePostLeftUpper,
    kHeroActionStatePreRightUpper,
    kHeroActionStateRightUpper,
    kHeroActionStatePostRightUpper,
    kHeroActionStateHitRight,
    kHeroActionStateHitLeft,
    kHeroActionStateBlocking,
} HeroActionState;

@interface TCHero : CCSprite

@property (assign, nonatomic) HeroDefenseState defenseState;
@property (assign, nonatomic) HeroAttackState attackState;
@property (assign, nonatomic) HeroActionState actionState;

@property (assign, nonatomic) CGPoint ringPosition;

- (void)respondToAttack:(BoxerAttackState)attack;

- (void)idle;
- (void)leftDodge;
- (void)rightDodge;

- (void)leftHit;
- (void)rightHit;

- (void)leftJab;
- (void)rightJab;
- (void)leftUpper;
- (void)rightUpper;

@end
