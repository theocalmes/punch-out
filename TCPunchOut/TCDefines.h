typedef enum {
    kDefenseNone = 0,
    kDefenseGaurdDown,
    kDefenseGaurdUp,
    kDefenseDodgeUp,
    kDefenseDodgeDown
} BoxerDefenseState;

typedef enum {
    kAttackNone = 0,
    kAttackLeftUpper,
    kAttackRightUpper,
    kAttackRightJab,
    kAttackLeftJab,
} HeroAttackState;