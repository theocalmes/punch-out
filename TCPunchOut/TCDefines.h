typedef enum {
    kBoxerDefenseNone = 0,
    kBoxerDefenseGaurdDown,
    kBoxerDefenseGaurdUp,
    kBoxerDefenseDodgeUp,
    kBoxerDefenseDodgeDown
} BoxerDefenseState;

typedef enum {
    kBoxerAttackNone = 0,
    kBoxerAttackBody,
    kBoxerAttackHead
} BoxerAttackState;

typedef enum {
    kHeroAttackNone = 0,
    kHeroAttackLeftUpper,
    kHeroAttackRightUpper,
    kHeroAttackRightJab,
    kHeroAttackLeftJab
} HeroAttackState;

typedef enum {
    kHeroDefenseNone = 0,
    kHeroDefenseBlock,
    kHeroDefenseDodgeLeft,
    kHeroDefenseDodgeRight
} HeroDefenseState;