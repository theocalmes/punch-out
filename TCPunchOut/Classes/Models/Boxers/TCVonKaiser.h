//
//  TCVonKaiser.h
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

#import "TCBoxer.h"

typedef enum {
    kActionStateNone = 0,
    kActionStateIdle,
    kActionStatePreJab,
    kActionStateJab,
    kActionStatePostJab
} BoxerActionState;

@class TCBoxerAction;

@interface TCVonKaiser : TCBoxer

@property (assign, nonatomic) BoxerActionState actionState;

// Actions
@property (strong, nonatomic) TCBoxerAction *idleAction;

@property (strong, nonatomic) TCBoxerAction *preJabAction;
@property (strong, nonatomic) TCBoxerAction *jabAction;
@property (strong, nonatomic) TCBoxerAction *postJabAction;

- (void)startJab;
- (void)idle;

@end
