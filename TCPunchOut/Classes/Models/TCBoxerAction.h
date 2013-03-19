//
//  TCBoxerAction.h
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

@interface TCBoxerAction : NSObject

@property (strong, nonatomic) id action;
@property (assign, nonatomic) NSInteger boxerState;
@property (assign, nonatomic) BoxerDefenseState defenseState;

- (id)initWithInitialSpriteFrame:(NSString *)spriteFileFrame;

@end
