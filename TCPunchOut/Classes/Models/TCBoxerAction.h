//
//  TCAction.h
//  TCPunchOut
//
//  Created by theo on 3/22/13.
//
//

@interface TCBoxerAction : NSObject

@property (strong, nonatomic) id action;
@property (strong, nonatomic) CCAnimation *annimation;
@property (assign, nonatomic) NSInteger boxerState;
@property (assign, nonatomic) NSInteger defenseState;
@property (assign, nonatomic) NSInteger attackState;

- (id)initWithBaseName:(NSString *)baseName frameNumbers:(NSArray *)numbers delay:(CGFloat)delay boxerState:(NSInteger)state;

- (void)repeatForeverAction;
- (void)sequenceWithTarget:(id)target callback:(SEL)callback;
- (void)moveByAmount:(CGPoint)amount target:(id)target callback:(SEL)callback;

@end
