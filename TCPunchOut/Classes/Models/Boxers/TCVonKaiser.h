//
//  TCVonKaiser.h
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCBoxer.h"

typedef enum {
    kBoxerActionStateNone = 0,
    kBoxerActionStateIdle,
    kBoxerActionStatePreJab,
    kBoxerActionStateJab,
    kBoxerActionStatePostJab,
    kBoxerActionStatePostJabReturn,
    kBoxerActionStateStunned,
    kBoxerActionStateBlocking,
    kBoxerActionStateBodyHit,
    kBoxerActionStateHeadHit
} BoxerActionState;

@class TCBoxerAction;

@interface TCVonKaiser : TCBoxer

@property (assign, nonatomic) BoxerActionState actionState;

// Actions
@property (strong, nonatomic) TCBoxerAction *idleAction;

- (void)startJab;
- (void)idle;

@end
