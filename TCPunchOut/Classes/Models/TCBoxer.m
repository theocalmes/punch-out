//
//  TCBoxer.m
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCBoxer.h"

@implementation TCBoxer

- (void)respondToAttack:(HeroAttackState)attack
{
    if (attack == kHeroAttackNone) return;

    switch (self.defenseState) {
        case kBoxerDefenseGaurdDown:
            switch (attack) {
                case kHeroAttackLeftJab:
                case kHeroAttackRightJab:
                    [self blockBody];
                    break;
                case kHeroAttackLeftUpper:
                    [self leftFaceHit];
                    break;
                case kHeroAttackRightUpper:
                    [self rightFaceHit];
                    break;
                default:
                    break;
            }
            break;
        case kBoxerDefenseGaurdUp:
            switch (attack) {
                case kHeroAttackLeftJab:
                case kHeroAttackRightJab:
                    [self bodyHit];
                    break;
                case kHeroAttackRightUpper:
                case kHeroAttackLeftUpper:
                    [self blockFace];
                    break;
                default:
                    break;
            }
        case kBoxerDefenseDodgeDown:
            switch (attack) {
                case kHeroAttackLeftJab:
                case kHeroAttackRightJab:
                    [self bodyHit];
                    break;
                default:
                    break;
            }
        default:
            break;
    }
}

- (void)blockBody {}
- (void)blockFace {}
- (void)bodyHit {}
- (void)leftFaceHit {}
- (void)rightFaceHit {}

@end
