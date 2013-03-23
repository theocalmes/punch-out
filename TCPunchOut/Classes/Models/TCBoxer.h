//
//  TCBoxer.h
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "CCSprite.h"

@interface TCBoxer : CCSprite

@property (assign, nonatomic) BoxerDefenseState defenseState;
@property (assign, nonatomic) BoxerAttackState attackState;

@property (assign, nonatomic) CGPoint ringPosition;

- (void)respondToAttack:(HeroAttackState)attack;

- (void)blockBody;
- (void)blockFace;
- (void)bodyHit;
- (void)leftFaceHit;
- (void)rightFaceHit;

@end
