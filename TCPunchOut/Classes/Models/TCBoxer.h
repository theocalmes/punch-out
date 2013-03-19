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

- (void)respondToUpper;
- (void)respondToJab;

@end
