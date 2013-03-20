//
//  TCBoxerAction.h
//  TCPunchOut
//
//  Created by Theodore Calmes on 3/19/13.
//
//

@class CCAnimation;

@interface TCBoxerAction : NSObject

@property (strong, nonatomic) id action;
@property (strong, nonatomic) CCAnimation *annimation;
@property (assign, nonatomic) NSInteger boxerState;
@property (assign, nonatomic) BoxerDefenseState defenseState;

- (id)initWithBaseName:(NSString *)baseName frameNumbers:(NSArray *)numbers delay:(CGFloat)delay boxerState:(NSInteger)state;

- (void)repeatForeverAction;
- (void)sequenceActionWithTarget:(id)target callback:(SEL)callback;

@end
