INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-0', 'srd', NULL, 'Damage and Healing (1)', '## Damage and Healing

Injury and the risk of death are constant companions of those who explore fantasy gaming worlds. The thrust of a sword, a well-placed arrow, or a blast of flame from a *fireball* spell all have the potential to damage, or even kill, the hardiest of creatures.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-1', 'srd', NULL, 'Damage and Healing (2)', '### Hit Points

Hit points represent a combination of physical and mental durability, the will to live, and luck. Creatures with more hit points are more difficult to kill. Those with fewer hit points are more fragile.

A creature''s current hit points (usually just called hit points) can be any number from the creature''s hit point maximum down to 0. This number changes frequently as a creature takes damage or receives healing.

Whenever a creature takes damage, that damage is subtracted from its hit points. The loss of hit points has no effect on a creature''s capabilities until the creature drops to 0 hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-2', 'srd', NULL, 'Damage and Healing (3)', '### Damage Rolls

Each weapon, spell, and harmful monster ability specifies the damage it deals. You roll the damage die or dice, add any modifiers, and apply the damage to your target. Magic weapons, special abilities, and other factors can grant a bonus to damage. With a penalty, it is possible to deal 0 damage, but never negative damage.

When attacking with a **weapon**, you add your ability modifier-the same modifier used for the attack roll-to the damage. A **spell** tells you which dice to roll for damage and whether to add any modifiers.

If a spell or other effect deals damage to **more** **than one target** at the same time, roll the damage once for all of them. For example, when a wizard casts *fireball* or a cleric casts *flame strike*, the spell''s damage is rolled once for all creatures caught in the blast.

#### Critical Hits

When you score a critical hit, you get to roll extra dice for the attack''s damage against the target. Roll all of the attack''s damage dice twice and add them together. Then add any relevant modifiers as normal. To speed up play, you can roll all the damage dice at once.

For example, if you score a critical hit with a dagger, roll 2d4 for the damage, rather than 1d4, and then add your relevant ability modifier. If the attack involves other damage dice, such as from the rogue''s Sneak Attack feature, you roll those dice twice as well.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-3', 'srd', NULL, 'Damage and Healing (4)', '#### Damage Types

Different attacks, damaging spells, and other harmful effects deal different types of damage. Damage types have no rules of their own, but other rules, such as damage resistance, rely on the types.

The damage types follow, with examples to help a GM assign a damage type to a new effect.

***Acid.*** The corrosive spray of a black dragon''s breath and the dissolving enzymes secreted by a black pudding deal acid damage.

***Bludgeoning.*** Blunt force attacks-hammers, falling, constriction, and the like-deal bludgeoning damage.

***Cold.*** The infernal chill radiating from an ice devil''s spear and the frigid blast of a white dragon''s breath deal cold damage.

***Fire.*** Red dragons breathe fire, and many spells conjure flames to deal fire damage.

***Force.*** Force is pure magical energy focused into a damaging form. Most effects that deal force damage are spells, including *magic missile* and *spiritual weapon*.

***Lightning.*** A *lightning bolt* spell and a blue dragon''s breath deal lightning damage.

***Necrotic.*** Necrotic damage, dealt by certain undead and a spell such as *chill touch*, withers matter and even the soul.

***Piercing.*** Puncturing and impaling attacks, including spears and monsters'' bites, deal piercing damage.

***Poison.*** Venomous stings and the toxic gas of a green dragon''s breath deal poison damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-4', 'srd', NULL, 'Damage and Healing (5)', '***Psychic.*** Mental abilities such as a mind flayer''s psionic blast deal psychic damage.

***Radiant.*** Radiant damage, dealt by a cleric''s *flame strike* spell or an angel''s smiting weapon, sears the flesh like fire and overloads the spirit with power.

***Slashing.*** Swords, axes, and monsters'' claws deal slashing damage.

***Thunder.*** A concussive burst of sound, such as the effect of the *thunderwave* spell, deals thunder damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-5', 'srd', NULL, 'Damage and Healing (6)', '### Damage Resistance and Vulnerability

Some creatures and objects are exceedingly difficult or unusually easy to hurt with certain types of damage.

If a creature or an object has **resistance** to a damage type, damage of that type is halved against it. If a creature or an object has **vulnerability** to a damage type, damage of that type is doubled against it.

Resistance and then vulnerability are applied after all other modifiers to damage. For example, a creature has resistance to bludgeoning damage and is hit by an attack that deals 25 bludgeoning damage. The creature is also within a magical aura that reduces all damage by 5. The 25 damage is first reduced by 5 and then halved, so the creature takes 10 damage.

Multiple instances of resistance or vulnerability that affect the same damage type count as only one instance. For example, if a creature has resistance to fire damage as well as resistance to all nonmagical damage, the damage of a nonmagical fire is reduced by half against the creature, not reduced by three-quarters.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-6', 'srd', NULL, 'Damage and Healing (7)', '### Healing

Unless it results in death, damage isn''t permanent. Even death is reversible through powerful magic. Rest can restore a creature''s hit points, and magical methods such as a *cure wounds* spell or a *potion of healing* can remove damage in an instant.

When a creature receives healing of any kind, hit points regained are added to its current hit points. A creature''s hit points can''t exceed its hit point maximum, so any hit points regained in excess of this number are lost. For example, a druid grants a ranger 8 hit points of healing. If the ranger has 14 current hit points and has a hit point maximum of 20, the ranger regains 6 hit points from the druid, not 8.

A creature that has died can''t regain hit points until magic such as the *revivify* spell has restored it to life.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-7', 'srd', NULL, 'Damage and Healing (8)', '### Dropping to 0 Hit Points

When you drop to 0 hit points, you either die outright or fall unconscious, as explained in the following sections.

#### Instant Death

Massive damage can kill you instantly. When damage reduces you to 0 hit points and there is damage remaining, you die if the remaining damage equals or exceeds your hit point maximum.

For example, a cleric with a maximum of 12 hit points currently has 6 hit points. If she takes 18 damage from an attack, she is reduced to 0 hit points, but 12 damage remains. Because the remaining damage equals her hit point maximum, the cleric dies.

#### Falling Unconscious

If damage reduces you to 0 hit points and fails to kill you, you fall unconscious (see appendix PH-A). This unconsciousness ends if you regain any hit points.

#### Death Saving Throws

Whenever you start your turn with 0 hit points, you must make a special saving throw, called a death saving throw, to determine whether you creep closer to death or hang onto life. Unlike other saving throws, this one isn''t tied to any ability score. You are in the hands of fate now, aided only by spells and features that improve your chances of succeeding on a saving throw.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-8', 'srd', NULL, 'Damage and Healing (9)', 'Roll a d20. If the roll is 10 or higher, you succeed. Otherwise, you fail. A success or failure has no effect by itself. On your third success, you become stable (see below). On your third failure, you die. The successes and failures don''t need to be consecutive; keep track of both until you collect three of a kind. The number of both is reset to zero when you regain any hit points or become stable.

***Rolling 1 or 20.*** When you make a death saving throw and roll a 1 on the d20, it counts as two failures. If you roll a 20 on the d20, you regain 1 hit point.

***Damage at 0 Hit Points.*** If you take any damage while you have 0 hit points, you suffer a death saving throw failure. If the damage is from a critical hit, you suffer two failures instead. If the damage equals or exceeds your hit point maximum, you suffer instant death.

#### Stabilizing a Creature

The best way to save a creature with 0 hit points is to heal it. If healing is unavailable, the creature can at least be stabilized so that it isn''t killed by a failed death saving throw.

You can use your action to administer first aid to an unconscious creature and attempt to stabilize it, which requires a successful DC 10 Wisdom (Medicine) check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-9', 'srd', NULL, 'Damage and Healing (10)', 'A **stable** creature doesn''t make death saving throws, even though it has 0 hit points, but it does remain unconscious. The creature stops being stable, and must start making death saving throws again, if it takes any damage. A stable creature that isn''t healed regains 1 hit point after 1d4 hours.

#### Monsters and Death

Most GMs have a monster die the instant it drops to 0 hit points, rather than having it fall unconscious and make death saving throws.

Mighty villains and special nonplayer characters are common exceptions; the GM might have them fall unconscious and follow the same rules as player characters.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-10', 'srd', NULL, 'Damage and Healing (11)', '### Knocking a Creature Out

Sometimes an attacker wants to incapacitate a foe, rather than deal a killing blow. When an attacker reduces a creature to 0 hit points with a melee attack, the attacker can knock the creature out. The attacker can make this choice the instant the damage is dealt. The creature falls unconscious and is stable.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-damage-and-healing-11', 'srd', NULL, 'Damage and Healing (12)', '### Temporary Hit Points

Some spells and special abilities confer temporary hit points to a creature. Temporary hit points aren''t actual hit points; they are a buffer against damage, a pool of hit points that protect you from injury.

When you have temporary hit points and take damage, the temporary hit points are lost first, and any leftover damage carries over to your normal hit points. For example, if you have 5 temporary hit points and take 7 damage, you lose the temporary hit points and then take 2 damage.

Because temporary hit points are separate from your actual hit points, they can exceed your hit point maximum. A character can, therefore, be at full hit points and receive temporary hit points.

Healing can''t restore temporary hit points, and they can''t be added together. If you have temporary hit points and receive more of them, you decide whether to keep the ones you have or to gain the new ones. For example, if a spell grants you 12 temporary hit points when you already have 10, you can have 12 or 10, not 22.

If you have 0 hit points, receiving temporary hit points doesn''t restore you to consciousness or stabilize you. They can still absorb damage directed at you while you''re in that state, but only true healing can save you.

Unless a feature that grants you temporary hit points has a duration, they last until they''re depleted or you finish a long rest.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-0', 'srd', NULL, 'Mounted Combat (1)', '## Mounted Combat

A knight charging into battle on a warhorse, a wizard casting spells from the back of a griffon, or a cleric soaring through the sky on a pegasus all enjoy the benefits of speed and mobility that a mount can provide.

A willing creature that is at least one size larger than you and that has an appropriate anatomy can serve as a mount, using the following rules.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-1', 'srd', NULL, 'Mounted Combat (2)', '### Mounting and Dismounting

Once during your move, you can mount a creature that is within 5 feet of you or dismount. Doing so costs an amount of movement equal to half your speed. For example, if your speed is 30 feet, you must spend 15 feet of movement to mount a horse. Therefore, you can''t mount it if you don''t have 15 feet of movement left or if your speed is 0.

If an effect moves your mount against its will while you''re on it, you must succeed on a DC 10 Dexterity saving throw or fall off the mount, landing prone in a space within 5 feet of it. If you''re knocked prone while mounted, you must make the same saving throw.

If your mount is knocked prone, you can use your reaction to dismount it as it falls and land on your feet. Otherwise, you are dismounted and fall prone in a space within 5 feet it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-mounted-combat-2', 'srd', NULL, 'Mounted Combat (3)', '### Controlling a Mount

While you''re mounted, you have two options. You can either control the mount or allow it to act independently. Intelligent creatures, such as dragons, act independently.

You can control a mount only if it has been trained to accept a rider. Domesticated horses, donkeys, and similar creatures are assumed to have such training. The initiative of a controlled mount changes to match yours when you mount it. It moves as you direct it, and it has only three action options: Dash, Disengage, and Dodge. A controlled mount can move and act even on the turn that you mount it.

An independent mount retains its place in the initiative order. Bearing a rider puts no restrictions on the actions the mount can take, and it moves and acts as it wishes. It might flee from combat, rush to attack and devour a badly injured foe, or otherwise act against your wishes.

In either case, if the mount provokes an opportunity attack while you''re on it, the attacker can target you or the mount.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-underwater-combat-0', 'srd', NULL, 'Underwater Combat', '## Underwater Combat

When adventurers pursue sahuagin back to their undersea homes, fight off sharks in an ancient shipwreck, or find themselves in a flooded dungeon room, they must fight in a challenging environment. Underwater the following rules apply.

When making a **melee weapon attack**, a creature that doesn''t have a swimming speed (either natural or granted by magic) has disadvantage on the attack roll unless the weapon is a dagger, javelin, shortsword, spear, or trident.

A **ranged weapon attack** automatically misses a target beyond the weapon''s normal range. Even against a target within normal range, the attack roll has disadvantage unless the weapon is a crossbow, a net, or a weapon that is thrown like a javelin (including a spear, trident, or dart).

Creatures and objects that are fully immersed in water have resistance to fire damage.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-scores-and-modifiers-0', 'srd', NULL, 'Ability Scores and Modifiers', '## Ability Scores and Modifiers

| Score | Modifier |
|-------|----------|
| 1     | -5       |
| 2-3   | -4       |
| 4-5   | -3       |
| 6-7   | -2       |
| 8-9   | -1       |
| 10-11 | +0       |
| 12-13 | +1       |
| 14-15 | +2       |
| 16-17 | +3       |
| 18-19 | +4       |
| 20-21 | +5       |
| 22-23 | +6       |
| 24-25 | +7       |
| 26-27 | +8       |
| 28-29 | +9       |
| 30    | +10      |

To determine an ability modifier without consulting the table, subtract 10 from the ability score and then divide the total by 2 (round down).

Because ability modifiers affect almost every attack roll, ability check, and saving throw, ability modifiers come up in play more often than their associated scores.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-advantage-and-disadvantage-0', 'srd', NULL, 'Advantage and Disadvantage (1)', '## Advantage and Disadvantage

Sometimes a special ability or spell tells you that you have advantage or disadvantage on an ability check, a saving throw, or an attack roll. When that happens, you roll a second d20 when you make the roll. Use the higher of the two rolls if you have advantage, and use the lower roll if you have disadvantage. For example, if you have disadvantage and roll a 17 and a 5, you use the 5. If you instead have advantage and roll those numbers, you use the 17.

If multiple situations affect a roll and each one grants advantage or imposes disadvantage on it, you don''t roll more than one additional d20. If two favorable situations grant advantage, for example, you still roll only one additional d20.

If circumstances cause a roll to have both advantage and disadvantage, you are considered to have neither of them, and you roll one d20. This is true even if multiple circumstances impose disadvantage and only one grants advantage or vice versa. In such a situation, you have neither advantage nor disadvantage.

When you have advantage or disadvantage and something in the game, such as the halfling''s Lucky trait, lets you reroll the d20, you can reroll only one of the dice. You choose which one. For example, if a halfling has advantage or disadvantage on an ability check and rolls a 1 and a 13, the halfling could use the Lucky trait to reroll the 1.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-advantage-and-disadvantage-1', 'srd', NULL, 'Advantage and Disadvantage (2)', 'You usually gain advantage or disadvantage through the use of special abilities, actions, or spells. Inspiration can also give a character advantage. The

GM can also decide that circumstances influence a roll in one direction or the other and grant advantage or impose disadvantage as a result.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-proficiency-bonus-0', 'srd', NULL, 'Proficiency Bonus (1)', '## Proficiency Bonus

Characters have a proficiency bonus determined by level. Monsters also have this bonus, which is incorporated in their stat blocks. The bonus is used in the rules on ability checks, saving throws, and attack rolls.

Your proficiency bonus can''t be added to a single die roll or other number more than once. For example, if two different rules say you can add your proficiency bonus to a Wisdom saving throw, you nevertheless add the bonus only once when you make the save.

Occasionally, your proficiency bonus might be multiplied or divided (doubled or halved, for example) before you apply it. For example, the rogue''s Expertise feature doubles the proficiency bonus for certain ability checks. If a circumstance suggests that your proficiency bonus applies more than once to the same roll, you still add it only once and multiply or divide it only once.

By the same token, if a feature or effect allows you to multiply your proficiency bonus when making an ability check that wouldn''t normally benefit from your proficiency bonus, you still don''t add the bonus to the check. For that check your proficiency bonus is 0, given the fact that multiplying 0 by any number is still 0. For instance, if you lack proficiency in the History skill, you gain no benefit from a feature that lets you double your proficiency bonus when you make Intelligence (History) checks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-proficiency-bonus-1', 'srd', NULL, 'Proficiency Bonus (2)', 'In general, you don''t multiply your proficiency bonus for attack rolls or saving throws. If a feature or effect allows you to do so, these same rules apply.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-0', 'srd', NULL, 'Ability Checks (1)', '## Ability Checks

An ability check tests a character''s or monster''s innate talent and training in an effort to overcome a challenge. The GM calls for an ability check when a character or monster attempts an action (other than an attack) that has a chance of failure. When the outcome is uncertain, the dice determine the results.

For every ability check, the GM decides which of the six abilities is relevant to the task at hand and the difficulty of the task, represented by a Difficulty Class.

The more difficult a task, the higher its DC. The Typical Difficulty Classes table shows the most common DCs.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-1', 'srd', NULL, 'Ability Checks (2)', '### Typical Difficulty Classes

| Task Difficulty   | DC |
|-------------------|----|
| Very easy         | 5  |
| Easy              | 10 |
| Medium            | 15 |
| Hard              | 20 |
| Very hard         | 25 |
| Nearly impossible | 30 |

To make an ability check, roll a d20 and add the relevant ability modifier. As with other d20 rolls, apply bonuses and penalties, and compare the total to the DC. If the total equals or exceeds the DC, the ability check is a success-the creature overcomes the challenge at hand. Otherwise, it''s a failure, which means the character or monster makes no progress toward the objective or makes progress combined with a setback determined by the GM.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-2', 'srd', NULL, 'Ability Checks (3)', '### Contests

Sometimes one character''s or monster''s efforts are directly opposed to another''s. This can occur when both of them are trying to do the same thing and only one can succeed, such as attempting to snatch up a magic ring that has fallen on the floor. This situation also applies when one of them is trying to prevent the other one from accomplishing a goal--for example, when a monster tries to force open a door that an adventurer is holding closed. In situations like these, the outcome is determined by a special form of ability check, called a contest.

Both participants in a contest make ability checks appropriate to their efforts. They apply all appropriate bonuses and penalties, but instead of comparing the total to a DC, they compare the totals of their two checks. The participant with the higher check total wins the contest. That character or monster either succeeds at the action or prevents the other one from succeeding.

If the contest results in a tie, the situation remains the same as it was before the contest. Thus, one contestant might win the contest by default. If two characters tie in a contest to snatch a ring off the floor, neither character grabs it. In a contest between a monster trying to open a door and an adventurer trying to keep the door closed, a tie means that the door remains shut.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-3', 'srd', NULL, 'Ability Checks (4)', '### Skills

Each ability covers a broad range of capabilities, including skills that a character or a monster can be proficient in. A skill represents a specific aspect of an ability score, and an individual''s proficiency in a skill demonstrates a focus on that aspect. (A character''s starting skill proficiencies are determined at character creation, and a monster''s skill proficiencies appear in the monster''s stat block.)

For example, a Dexterity check might reflect a character''s attempt to pull off an acrobatic stunt, to palm an object, or to stay hidden. Each of these aspects of Dexterity has an associated skill: Acrobatics, Sleight of Hand, and Stealth, respectively. So a character who has proficiency in the Stealth skill is particularly good at Dexterity checks related to sneaking and hiding.

The skills related to each ability score are shown in the following list. (No skills are related to Constitution.) See an ability''s description in the later sections of this section for examples of how to use a skill associated with an ability.

#### Strength
- Athletics

#### Dexterity
- Acrobatics
- Sleight of Hand
- Stealth

#### Intelligence
- Arcana
- History
- Investigation
- Nature
- Religion

#### Wisdom
- Animal Handling
- Insight
- Medicine
- Perception
- Survival

#### Charisma
- Deception
- Intimidation
- Performance
- Persuasion', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-4', 'srd', NULL, 'Ability Checks (5)', 'Sometimes, the GM might ask for an ability check using a specific skill-for example, "Make a Wisdom (Perception) check." At other times, a player might ask the GM if proficiency in a particular skill applies to a check. In either case, proficiency in a skill means an individual can add his or her proficiency bonus to ability checks that involve that skill. Without proficiency in the skill, the individual makes a normal ability check.

For example, if a character attempts to climb up a dangerous cliff, the GM might ask for a Strength (Athletics) check. If the character is proficient in Athletics, the character''s proficiency bonus is added to the Strength check. If the character lacks that proficiency, he or she just makes a Strength check.

#### Variant: Skills with Different Abilities', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-5', 'srd', NULL, 'Ability Checks (6)', 'Normally, your proficiency in a skill applies only to a specific kind of ability check. Proficiency in Athletics, for example, usually applies to Strength checks. In some situations, though, your proficiency might reasonably apply to a different kind of check. In such cases, the GM might ask for a check using an unusual combination of ability and skill, or you might ask your GM if you can apply a proficiency to a different check. For example, if you have to swim from an offshore island to the mainland, your GM might call for a Constitution check to see if you have the stamina to make it that far. In this case, your GM might allow you to apply your proficiency in Athletics and ask for a Constitution (Athletics) check. So if you''re proficient in Athletics, you apply your proficiency bonus to the Constitution check just as you would normally do for a Strength (Athletics) check. Similarly, when your half-orc barbarian uses a display of raw strength to intimidate an enemy, your GM might ask for a Strength (Intimidation) check, even though Intimidation is normally associated with Charisma.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-6', 'srd', NULL, 'Ability Checks (7)', '### Passive Checks

A passive check is a special kind of ability check that doesn''t involve any die rolls. Such a check can represent the average result for a task done repeatedly, such as searching for secret doors over and over again, or can be used when the GM wants to secretly determine whether the characters succeed at something without rolling dice, such as noticing a hidden monster.

Here''s how to determine a character''s total for a passive check:

10 + all modifiers that normally apply to the check

If the character has advantage on the check, add 5. For disadvantage, subtract 5. The game refers to a passive check total as a **score**.

For example, if a 1st-level character has a Wisdom of 15 and proficiency in Perception, he or she has a passive Wisdom (Perception) score of 14.

The rules on hiding in the "Dexterity" section below rely on passive checks, as do the exploration rules.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-7', 'srd', NULL, 'Ability Checks (8)', '### Working Together

Sometimes two or more characters team up to attempt a task. The character who''s leading the effort-or the one with the highest ability modifier-can make an ability check with advantage, reflecting the help provided by the other characters. In combat, this requires the Help action.

A character can only provide help if the task is one that he or she could attempt alone. For example, trying to open a lock requires proficiency with thieves'' tools, so a character who lacks that proficiency can''t help another character in that task. Moreover, a character can help only when two or more individuals working together would actually be productive. Some tasks, such as threading a needle, are no easier with help.

#### Group Checks

When a number of individuals are trying to accomplish something as a group, the GM might ask for a group ability check. In such a situation, the characters who are skilled at a particular task help cover those who aren''t.

To make a group ability check, everyone in the group makes the ability check. If at least half the group succeeds, the whole group succeeds. Otherwise, the group fails.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-ability-checks-8', 'srd', NULL, 'Ability Checks (9)', 'Group checks don''t come up very often, and they''re most useful when all the characters succeed or fail as a group. For example, when adventurers are navigating a swamp, the GM might call for a group Wisdom (Survival) check to see if the characters can avoid the quicksand, sinkholes, and other natural hazards of the environment. If at least half the group succeeds, the successful characters are able to guide their companions out of danger. Otherwise, the group stumbles into one of these hazards.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-0', 'srd', NULL, 'Using Each Ability (1)', '## Using Each Ability

Every task that a character or monster might attempt in the game is covered by one of the six abilities. This section explains in more detail what those abilities mean and the ways they are used in the game.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-1', 'srd', NULL, 'Using Each Ability (2)', '### Strength

Strength measures bodily power, athletic training, and the extent to which you can exert raw physical force.

#### Strength Checks

A Strength check can model any attempt to lift, push, pull, or break something, to force your body through a space, or to otherwise apply brute force to a situation. The Athletics skill reflects aptitude in certain kinds of Strength checks.

***Athletics.*** Your Strength (Athletics) check covers difficult situations you encounter while climbing, jumping, or swimming. Examples include the following activities:
- You attempt to climb a sheer or slippery cliff, avoid hazards while scaling a wall, or cling to a surface while something is trying to knock you off.
- You try to jump an unusually long distance or pull off a stunt midjump.
- You struggle to swim or stay afloat in treacherous currents, storm-tossed waves, or areas of thick seaweed. Or another creature tries to push or pull you underwater or otherwise interfere with your swimming.

***Other Strength Checks.*** The GM might also call for a Strength check when you try to accomplish tasks like the following:
- Force open a stuck, locked, or barred door
- Break free of bonds
- Push through a tunnel that is too small
- Hang on to a wagon while being dragged behind it
- Tip over a statue
- Keep a boulder from rolling

#### Attack Rolls and Damage', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-2', 'srd', NULL, 'Using Each Ability (3)', 'You add your Strength modifier to your attack roll and your damage roll when attacking with a melee weapon such as a mace, a battleaxe, or a javelin. You use melee weapons to make melee attacks in hand-to-hand combat, and some of them can be thrown to make a ranged attack.

#### Lifting and Carrying

Your Strength score determines the amount of weight you can bear. The following terms define what you can lift or carry.

***Carrying Capacity.*** Your carrying capacity is your Strength score multiplied by 15. This is the weight (in pounds) that you can carry, which is high enough that most characters don''t usually have to worry about it.

***Push, Drag, or Lift.*** You can push, drag, or lift a weight in pounds up to twice your carrying capacity (or 30 times your Strength score). While pushing or dragging weight in excess of your carrying capacity, your speed drops to 5 feet.

***Size and Strength.*** Larger creatures can bear more weight, whereas Tiny creatures can carry less. For each size category above Medium, double the creature''s carrying capacity and the amount it can push, drag, or lift. For a Tiny creature, halve these weights.

##### Variant: Encumbrance', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-3', 'srd', NULL, 'Using Each Ability (4)', 'The rules for lifting and carrying are intentionally simple. Here is a variant if you are looking for more detailed rules for determining how a character is hindered by the weight of equipment. When you use this variant, ignore the Strength column of the Armor table.

If you carry weight in excess of 5 times your Strength score, you are **encumbered**, which means your speed drops by 10 feet.

If you carry weight in excess of 10 times your Strength score, up to your maximum carrying capacity, you are instead **heavily encumbered**, which means your speed drops by 20 feet and you have disadvantage on ability checks, attack rolls, and saving throws that use Strength, Dexterity, or Constitution.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-4', 'srd', NULL, 'Using Each Ability (5)', '### Dexterity

Dexterity measures agility, reflexes, and balance.

#### Dexterity Checks

A Dexterity check can model any attempt to move nimbly, quickly, or quietly, or to keep from falling on tricky footing. The Acrobatics, Sleight of Hand, and Stealth skills reflect aptitude in certain kinds of Dexterity checks.

***Acrobatics.*** Your Dexterity (Acrobatics) check covers your attempt to stay on your feet in a tricky situation, such as when you''re trying to run across a sheet of ice, balance on a tightrope, or stay upright on a rocking ship''s deck. The GM might also call for a Dexterity (Acrobatics) check to see if you can perform acrobatic stunts, including dives, rolls, somersaults, and flips.

***Sleight of Hand.*** Whenever you attempt an act of legerdemain or manual trickery, such as planting something on someone else or concealing an object on your person, make a Dexterity (Sleight of Hand) check. The GM might also call for a Dexterity (Sleight of Hand) check to determine whether you can lift a coin purse off another person or slip something out of another person''s pocket.

***Stealth.*** Make a Dexterity (Stealth) check when you attempt to conceal yourself from enemies, slink past guards, slip away without being noticed, or sneak up on someone without being seen or heard.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-5', 'srd', NULL, 'Using Each Ability (6)', '***Other Dexterity Checks.*** The GM might call for a Dexterity check when you try to accomplish tasks like the following:
- Control a heavily laden cart on a steep descent
- Steer a chariot around a tight turn
- Pick a lock
- Disable a trap
- Securely tie up a prisoner
- Wriggle free of bonds
- Play a stringed instrument
- Craft a small or detailed object

#### Attack Rolls and Damage

You add your Dexterity modifier to your attack roll and your damage roll when attacking with a ranged weapon, such as a sling or a longbow. You can also add your Dexterity modifier to your attack roll and your damage roll when attacking with a melee weapon that has the finesse property, such as a dagger or a rapier.

#### Armor Class

Depending on the armor you wear, you might add some or all of your Dexterity modifier to your Armor Class.

#### Initiative

At the beginning of every combat, you roll initiative by making a Dexterity check. Initiative determines the order of creatures'' turns in combat.

#### Hiding

The GM decides when circumstances are appropriate for hiding. When you try to hide, make a Dexterity (Stealth) check. Until you are discovered or you stop hiding, that check''s total is contested by the Wisdom (Perception) check of any creature that actively searches for signs of your presence.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-6', 'srd', NULL, 'Using Each Ability (7)', 'You can''t hide from a creature that can see you clearly, and you give away your position if you make noise, such as shouting a warning or knocking over a vase.

An invisible creature can always try to hide. Signs of its passage might still be noticed, and it does have to stay quiet.

In combat, most creatures stay alert for signs of danger all around, so if you come out of hiding and approach a creature, it usually sees you. However, under certain circumstances, the GM might allow you to stay hidden as you approach a creature that is distracted, allowing you to gain advantage on an attack roll before you are seen.

***Passive Perception.*** When you hide, there''s a chance someone will notice you even if they aren''t searching. To determine whether such a creature notices you, the GM compares your Dexterity (Stealth) check with that creature''s passive Wisdom (Perception) score, which equals 10 + the creature''s Wisdom modifier, as well as any other bonuses or penalties. If the creature has advantage, add 5. For disadvantage, subtract 5. For example, if a 1st-level character (with a proficiency bonus of +2) has a Wisdom of 15 (a +2 modifier) and proficiency in Perception, he or she has a passive Wisdom (Perception) of 14.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-7', 'srd', NULL, 'Using Each Ability (8)', '***What Can You See?*** One of the main factors in determining whether you can find a hidden creature or object is how well you can see in an area, which might be **lightly** or **heavily obscured**, as explained in chapter 8, "Adventuring."', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-8', 'srd', NULL, 'Using Each Ability (9)', '### Constitution

Constitution measures health, stamina, and vital force.

#### Constitution Checks

Constitution checks are uncommon, and no skills apply to Constitution checks, because the endurance this ability represents is largely passive rather than involving a specific effort on the part of a character or monster. A Constitution check can model your attempt to push beyond normal limits, however.

The GM might call for a Constitution check when you try to accomplish tasks like the following:
- Hold your breath
- March or labor for hours without rest
- Go without sleep
- Survive without food or water
- Quaff an entire stein of ale in one go

#### Hit Points

Your Constitution modifier contributes to your hit points. Typically, you add your Constitution modifier to each Hit Die you roll for your hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-9', 'srd', NULL, 'Using Each Ability (10)', 'If your Constitution modifier changes, your hit point maximum changes as well, as though you had the new modifier from 1st level. For example, if you raise your Constitution score when you reach 4th level and your Constitution modifier increases from +1 to +2, you adjust your hit point maximum as though the modifier had always been +2. So you add 3 hit points for your first three levels, and then roll your hit points for 4th level using your new modifier. Or if you''re 7th level and some effect lowers your Constitution score so as to reduce your Constitution modifier by 1, your hit point maximum is reduced by 7.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-10', 'srd', NULL, 'Using Each Ability (11)', '### Intelligence

Intelligence measures mental acuity, accuracy of recall, and the ability to reason.

#### Intelligence Checks

An Intelligence check comes into play when you need to draw on logic, education, memory, or deductive reasoning. The Arcana, History, Investigation, Nature, and Religion skills reflect aptitude in certain kinds of Intelligence checks.

***Arcana.*** Your Intelligence (Arcana) check measures your ability to recall lore about spells, magic items, eldritch symbols, magical traditions, the planes of existence, and the inhabitants of those planes.

***History.*** Your Intelligence (History) check measures your ability to recall lore about historical events, legendary people, ancient kingdoms, past disputes, recent wars, and lost civilizations.

***Investigation.*** When you look around for clues and make deductions based on those clues, you make an Intelligence (Investigation) check. You might deduce the location of a hidden object, discern from the appearance of a wound what kind of weapon dealt it, or determine the weakest point in a tunnel that could cause it to collapse. Poring through ancient scrolls in search of a hidden fragment of knowledge might also call for an Intelligence (Investigation) check.

***Nature.*** Your Intelligence (Nature) check measures your ability to recall lore about terrain, plants and animals, the weather, and natural cycles.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-11', 'srd', NULL, 'Using Each Ability (12)', '***Religion.*** Your Intelligence (Religion) check measures your ability to recall lore about deities, rites and prayers, religious hierarchies, holy symbols, and the practices of secret cults.

***Other Intelligence Checks.*** The GM might call for an Intelligence check when you try to accomplish tasks like the following:
- Communicate with a creature without using words
- Estimate the value of a precious item
- Pull together a disguise to pass as a city guard
- Forge a document
- Recall lore about a craft or trade
- Win a game of skill

#### Spellcasting Ability

Wizards use Intelligence as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-12', 'srd', NULL, 'Using Each Ability (13)', '### Wisdom

Wisdom reflects how attuned you are to the world around you and represents perceptiveness and intuition.

#### Wisdom Checks

A Wisdom check might reflect an effort to read body language, understand someone''s feelings, notice things about the environment, or care for an injured person. The Animal Handling, Insight, Medicine, Perception, and Survival skills reflect aptitude in certain kinds of Wisdom checks.

***Animal Handling.*** When there is any question whether you can calm down a domesticated animal, keep a mount from getting spooked, or intuit an animal''s intentions, the GM might call for a Wisdom (Animal Handling) check. You also make a Wisdom (Animal Handling) check to control your mount when you attempt a risky maneuver.

***Insight.*** Your Wisdom (Insight) check decides whether you can determine the true intentions of a creature, such as when searching out a lie or predicting someone''s next move. Doing so involves gleaning clues from body language, speech habits, and changes in mannerisms.

***Medicine.*** A Wisdom (Medicine) check lets you try to stabilize a dying companion or diagnose an illness.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-13', 'srd', NULL, 'Using Each Ability (14)', '***Perception.*** Your Wisdom (Perception) check lets you spot, hear, or otherwise detect the presence of something. It measures your general awareness of your surroundings and the keenness of your senses. For example, you might try to hear a conversation through a closed door, eavesdrop under an open window, or hear monsters moving stealthily in the forest. Or you might try to spot things that are obscured or easy to miss, whether they are orcs lying in ambush on a road, thugs hiding in the shadows of an alley, or candlelight under a closed secret door.

***Survival.*** The GM might ask you to make a

Wisdom (Survival) check to follow tracks, hunt wild game, guide your group through frozen wastelands, identify signs that owlbears live nearby, predict the weather, or avoid quicksand and other natural hazards.

***Other Wisdom Checks.*** The GM might call for a

Wisdom check when you try to accomplish tasks like the following:
- Get a gut feeling about what course of action to follow
- Discern whether a seemingly dead or living creature is undead

#### Spellcasting Ability

Clerics, druids, and rangers use Wisdom as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-14', 'srd', NULL, 'Using Each Ability (15)', '### Charisma

Charisma measures your ability to interact effectively with others. It includes such factors as confidence and eloquence, and it can represent a charming or commanding personality.

#### Charisma Checks

A Charisma check might arise when you try to influence or entertain others, when you try to make an impression or tell a convincing lie, or when you are navigating a tricky social situation. The Deception, Intimidation, Performance, and Persuasion skills reflect aptitude in certain kinds of Charisma checks.

***Deception.*** Your Charisma (Deception) check determines whether you can convincingly hide the truth, either verbally or through your actions. This deception can encompass everything from misleading others through ambiguity to telling outright lies. Typical situations include trying to fast- talk a guard, con a merchant, earn money through gambling, pass yourself off in a disguise, dull someone''s suspicions with false assurances, or maintain a straight face while telling a blatant lie.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-15', 'srd', NULL, 'Using Each Ability (16)', '***Intimidation.*** When you attempt to influence someone through overt threats, hostile actions, and physical violence, the GM might ask you to make a Charisma (Intimidation) check. Examples include trying to pry information out of a prisoner, convincing street thugs to back down from a confrontation, or using the edge of a broken bottle to convince a sneering vizier to reconsider a decision.

***Performance.*** Your Charisma (Performance) check determines how well you can delight an audience with music, dance, acting, storytelling, or some other form of entertainment.

***Persuasion.*** When you attempt to influence someone or a group of people with tact, social graces, or good nature, the GM might ask you to make a Charisma (Persuasion) check. Typically, you use persuasion when acting in good faith, to foster friendships, make cordial requests, or exhibit proper etiquette. Examples of persuading others include convincing a chamberlain to let your party see the king, negotiating peace between warring tribes, or inspiring a crowd of townsfolk.

***Other Charisma Checks.*** The GM might call for a Charisma check when you try to accomplish tasks like the following:
- Find the best person to talk to for news, rumors, and gossip
- Blend into a crowd to get the sense of key topics of conversation

#### Spellcasting Ability', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-using-each-ability-16', 'srd', NULL, 'Using Each Ability (17)', 'Bards, paladins, sorcerers, and warlocks use Charisma as their spellcasting ability, which helps determine the saving throw DCs of spells they cast.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-saving-throws-0', 'srd', NULL, 'Saving Throws', '## Saving Throws

A saving throw-also called a save-represents an attempt to resist a spell, a trap, a poison, a disease, or a similar threat. You don''t normally decide to make a saving throw; you are forced to make one because your character or monster is at risk of harm.

To make a saving throw, roll a d20 and add the appropriate ability modifier. For example, you use your Dexterity modifier for a Dexterity saving throw.

A saving throw can be modified by a situational bonus or penalty and can be affected by advantage and disadvantage, as determined by the GM.

Each class gives proficiency in at least two saving throws. The wizard, for example, is proficient in Intelligence saves. As with skill proficiencies, proficiency in a saving throw lets a character add his or her proficiency bonus to saving throws made using a particular ability score. Some monsters have saving throw proficiencies as well.

The Difficulty Class for a saving throw is determined by the effect that causes it. For example, the DC for a saving throw allowed by a spell is determined by the caster''s spellcasting ability and proficiency bonus.

The result of a successful or failed saving throw is also detailed in the effect that allows the save. Usually, a successful save means that a creature suffers no harm, or reduced harm, from an effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-time-0', 'srd', NULL, 'Time', '## Time

In situations where keeping track of the passage of time is important, the GM determines the time a task requires. The GM might use a different time scale depending on the context of the situation at hand. In a dungeon environment, the adventurers'' movement happens on a scale of **minutes**. It takes them about a minute to creep down a long hallway, another minute to check for traps on the door at the end of the hall, and a good ten minutes to search the chamber beyond for anything interesting or valuable.

In a city or wilderness, a scale of **hours** is often more appropriate. Adventurers eager to reach the lonely tower at the heart of the forest hurry across those fifteen miles in just under four hours'' time.

For long journeys, a scale of **days** works best.

Following the road from Baldur''s Gate to Waterdeep, the adventurers spend four uneventful days before a goblin ambush interrupts their journey.

In combat and other fast-paced situations, the game relies on **rounds**, a 6-second span of time.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-0', 'srd', NULL, 'Movement (1)', '## Movement

Swimming across a rushing river, sneaking down a dungeon corridor, scaling a treacherous mountain slope-all sorts of movement play a key role in fantasy gaming adventures.

The GM can summarize the adventurers'' movement without calculating exact distances or travel times: "You travel through the forest and find the dungeon entrance late in the evening of the third day." Even in a dungeon, particularly a large dungeon or a cave network, the GM can summarize movement between encounters: "After killing the guardian at the entrance to the ancient dwarven stronghold, you consult your map, which leads you through miles of echoing corridors to a chasm bridged by a narrow stone arch."

Sometimes it''s important, though, to know how long it takes to get from one spot to another, whether the answer is in days, hours, or minutes. The rules for determining travel time depend on two factors: the speed and travel pace of the creatures moving and the terrain they''re moving over.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-1', 'srd', NULL, 'Movement (2)', '### Speed

Every character and monster has a speed, which is the distance in feet that the character or monster can walk in 1 round. This number assumes short bursts of energetic movement in the midst of a life-threatening situation.

The following rules determine how far a character or monster can move in a minute, an hour, or a day.

#### Travel Pace

While traveling, a group of adventurers can move at a normal, fast, or slow pace, as shown on the Travel Pace table. The table states how far the party can move in a period of time and whether the pace has any effect. A fast pace makes characters less perceptive, while a slow pace makes it possible to sneak around and to search an area more carefully.

***Forced March.*** The Travel Pace table assumes that characters travel for 8 hours in day. They can push on beyond that limit, at the risk of exhaustion.

For each additional hour of travel beyond 8 hours, the characters cover the distance shown in the Hour column for their pace, and each character must make a Constitution saving throw at the end of the hour. The DC is 10 + 1 for each hour past 8 hours. On a failed saving throw, a character suffers one level of exhaustion (see appendix PH-A).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-2', 'srd', NULL, 'Movement (3)', '***Mounts and Vehicles.*** For short spans of time (up to an hour), many animals move much faster than humanoids. A mounted character can ride at a gallop for about an hour, covering twice the usual distance for a fast pace. If fresh mounts are available every 8 to 10 miles, characters can cover larger distances at this pace, but this is very rare except in densely populated areas.

Characters in wagons, carriages, or other land vehicles choose a pace as normal. Characters in a waterborne vessel are limited to the speed of the vessel, and they don''t suffer penalties for a fast pace or gain benefits from a slow pace. Depending on the vessel and the size of the crew, ships might be able to travel for up to 24 hours per day.

Certain special mounts, such as a pegasus or griffon, or special vehicles, such as a *carpet of flying*, allow you to travel more swiftly.

##### Travel Pace', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-3', 'srd', NULL, 'Movement (4)', '| Pace   | Distance per: Minute | Hour    | Day      | Effect                                           |
|--------|----------------------|---------|----------|--------------------------------------------------|
| Fast   | 400 feet             | 4 miles | 30 miles | -5 penalty to passive Wisdom (Perception) scores |
| Normal | 300 feet             | 3 miles | 24 miles | -                                                |
| Slow   | 200 feet             | 2 miles | 18 miles | Able to use stealth                              |

#### Difficult Terrain

The travel speeds given in the Travel Pace table assume relatively simple terrain: roads, open plains, or clear dungeon corridors. But adventurers often face dense forests, deep swamps, rubble-filled ruins, steep mountains, and ice-covered ground-all considered difficult terrain.

You move at half speed in difficult terrain--moving 1 foot in difficult terrain costs 2 feet of speed-so you can cover only half the normal distance in a minute, an hour, or a day.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-4', 'srd', NULL, 'Movement (5)', '### Special Types of Movement

Movement through dangerous dungeons or wilderness areas often involves more than simply walking. Adventurers might have to climb, crawl, swim, or jump to get where they need to go.

#### Climbing, Swimming, and Crawling

While climbing or swimming, each foot of movement costs 1 extra foot (2 extra feet in difficult terrain), unless a creature has a climbing or swimming speed. At the GM''s option, climbing a slippery vertical surface or one with few handholds requires a successful Strength (Athletics) check. Similarly, gaining any distance in rough water might require a successful Strength (Athletics) check.

#### Jumping

Your Strength determines how far you can jump.

***Long Jump.*** When you make a long jump, you cover a number of feet up to your Strength score if you move at least 10 feet on foot immediately before the jump. When you make a standing long jump, you can leap only half that distance. Either way, each foot you clear on the jump costs a foot of movement.

This rule assumes that the height of your jump doesn''t matter, such as a jump across a stream or chasm. At your GM''s option, you must succeed on a DC 10 Strength (Athletics) check to clear a low obstacle (no taller than a quarter of the jump''s distance), such as a hedge or low wall. Otherwise, you hit it.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-movement-5', 'srd', NULL, 'Movement (6)', 'When you land in difficult terrain, you must succeed on a DC 10 Dexterity (Acrobatics) check to land on your feet. Otherwise, you land prone.

***High Jump.*** When you make a high jump, you leap into the air a number of feet equal to 3 + your Strength modifier if you move at least 10 feet on foot immediately before the jump. When you make a standing high jump, you can jump only half that distance. Either way, each foot you clear on the jump costs a foot of movement. In some circumstances, your GM might allow you to make a Strength (Athletics) check to jump higher than you normally can.

You can extend your arms half your height above yourself during the jump. Thus, you can reach above you a distance equal to the height of the jump plus 1.5 times your height.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-0', 'srd', NULL, 'The Environment (1)', '## The Environment

By its nature, adventuring involves delving into places that are dark, dangerous, and full of mysteries to be explored. The rules in this section cover some of the most important ways in which adventurers interact with the environment in such places.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-1', 'srd', NULL, 'The Environment (2)', '### Falling

A fall from a great height is one of the most common hazards facing an adventurer. At the end of a fall, a creature takes 1d6 bludgeoning damage for every 10 feet it fell, to a maximum of 20d6. The creature lands prone, unless it avoids taking damage from the fall.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-2', 'srd', NULL, 'The Environment (3)', '### Suffocating

A creature can hold its breath for a number of minutes equal to 1 + its Constitution modifier (minimum of 30 seconds).

When a creature runs out of breath or is choking, it can survive for a number of rounds equal to its Constitution modifier (minimum of 1 round). At the start of its next turn, it drops to 0 hit points and is dying, and it can''t regain hit points or be stabilized until it can breathe again.

For example, a creature with a Constitution of 14 can hold its breath for 3 minutes. If it starts suffocating, it has 2 rounds to reach air before it drops to 0 hit points.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-3', 'srd', NULL, 'The Environment (4)', '### Vision and Light

The most fundamental tasks of adventuring--noticing danger, finding hidden objects, hitting an enemy in combat, and targeting a spell, to name just a few--rely heavily on a character''s ability to see. Darkness and other effects that obscure vision can prove a significant hindrance.

A given area might be lightly or heavily obscured. In a **lightly obscured** area, such as dim light, patchy fog, or moderate foliage, creatures have disadvantage on Wisdom (Perception) checks that rely on sight.

A **heavily obscured** area-such as darkness, opaque fog, or dense foliage-blocks vision entirely. A creature effectively suffers from the blinded condition (see appendix PH-A) when trying to see something in that area.

The presence or absence of light in an environment creates three categories of illumination: bright light, dim light, and darkness.

**Bright light** lets most creatures see normally.

Even gloomy days provide bright light, as do torches, lanterns, fires, and other sources of illumination within a specific radius.

**Dim light**, also called shadows, creates a lightly obscured area. An area of dim light is usually a boundary between a source of bright light, such as a torch, and surrounding darkness. The soft light of twilight and dawn also counts as dim light. A particularly brilliant full moon might bathe the land in dim light.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-4', 'srd', NULL, 'The Environment (5)', '**Darkness** creates a heavily obscured area.

Characters face darkness outdoors at night (even most moonlit nights), within the confines of an unlit dungeon or a subterranean vault, or in an area of magical darkness.

#### Blindsight

A creature with blindsight can perceive its surroundings without relying on sight, within a specific radius. Creatures without eyes, such as oozes, and creatures with echolocation or heightened senses, such as bats and true dragons, have this sense.

#### Darkvision

Many creatures in fantasy gaming worlds, especially those that dwell underground, have darkvision. Within a specified range, a creature with darkvision can see in darkness as if the darkness were dim light, so areas of darkness are only lightly obscured as far as that creature is concerned. However, the creature can''t discern color in darkness, only shades of gray.

#### Truesight

A creature with truesight can, out to a specific range, see in normal and magical darkness, see invisible creatures and objects, automatically detect visual illusions and succeed on saving throws against them, and perceives the original form of a shapechanger or a creature that is transformed by magic. Furthermore, the creature can see into the Ethereal Plane.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-5', 'srd', NULL, 'The Environment (6)', '### Food and Water

Characters who don''t eat or drink suffer the effects of exhaustion (see appendix PH-A). Exhaustion caused by lack of food or water can''t be removed until the character eats and drinks the full required amount.

#### Food

A character needs one pound of food per day and can make food last longer by subsisting on half rations. Eating half a pound of food in a day counts as half a day without food.

A character can go without food for a number of days equal to 3 + his or her Constitution modifier (minimum 1). At the end of each day beyond that limit, a character automatically suffers one level of exhaustion.

A normal day of eating resets the count of days without food to zero.

#### Water

A character needs one gallon of water per day, or two gallons per day if the weather is hot. A character who drinks only half that much water must succeed on a DC 15 Constitution saving throw or suffer one level of exhaustion at the end of the day. A character with access to even less water automatically suffers one level of exhaustion at the end of the day.

If the character already has one or more levels of exhaustion, the character takes two levels in either case.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-6', 'srd', NULL, 'The Environment (7)', '### Interacting with Objects

A character''s interaction with objects in an environment is often simple to resolve in the game. The player tells the GM that his or her character is doing something, such as moving a lever, and the GM describes what, if anything, happens.

For example, a character might decide to pull a lever, which might, in turn, raise a portcullis, cause a room to flood with water, or open a secret door in a nearby wall. If the lever is rusted in position, though, a character might need to force it. In such a situation, the GM might call for a Strength check to see whether the character can wrench the lever into place. The GM sets the DC for any such check based on the difficulty of the task.

Characters can also damage objects with their weapons and spells. Objects are immune to poison and psychic damage, but otherwise they can be affected by physical and magical attacks much like creatures can. The GM determines an object''s Armor Class and hit points, and might decide that certain objects have resistance or immunity to certain kinds of attacks. (It''s hard to cut a rope with a club, for example.) Objects always fail Strength and Dexterity saving throws, and they are immune to effects that require other saves. When an object drops to 0 hit points, it breaks.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-the-environment-7', 'srd', NULL, 'The Environment (8)', 'A character can also attempt a Strength check to break an object. The GM sets the DC for any such check.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-0', 'srd', NULL, 'Resting (1)', '## Resting

Heroic though they might be, adventurers can''t spend every hour of the day in the thick of exploration, social interaction, and combat. They need rest-time to sleep and eat, tend their wounds, refresh their minds and spirits for spellcasting, and brace themselves for further adventure.

Adventurers can take short rests in the midst of an adventuring day and a long rest to end the day.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-1', 'srd', NULL, 'Resting (2)', '### Short Rest

A short rest is a period of downtime, at least 1 hour long, during which a character does nothing more strenuous than eating, drinking, reading, and tending to wounds.

A character can spend one or more Hit Dice at the end of a short rest, up to the character''s maximum number of Hit Dice, which is equal to the character''s level. For each Hit Die spent in this way, the player rolls the die and adds the character''s Constitution modifier to it. The character regains hit points equal to the total. The player can decide to spend an additional Hit Die after each roll. A character regains some spent Hit Dice upon finishing a long rest, as explained below.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-resting-2', 'srd', NULL, 'Resting (3)', '### Long Rest

A long rest is a period of extended downtime, at least 8 hours long, during which a character sleeps or performs light activity: reading, talking, eating, or standing watch for no more than 2 hours. If the rest is interrupted by a period of strenuous activity-at least 1 hour of walking, fighting, casting spells, or similar adventuring activity-the characters must begin the rest again to gain any benefit from it.

At the end of a long rest, a character regains all lost hit points. The character also regains spent Hit Dice, up to a number of dice equal to half of the character''s total number of them (minimum of one die). For example, if a character has eight Hit Dice, he or she can regain four spent Hit Dice upon finishing a long rest.

A character can''t benefit from more than one long rest in a 24-hour period, and a character must have at least 1 hit point at the start of the rest to gain its benefits.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-0', 'srd', NULL, 'Between Adventures (1)', '## Between Adventures

Between trips to dungeons and battles against ancient evils, adventurers need time to rest, recuperate, and prepare for their next adventure. Many adventurers also use this time to perform other tasks, such as crafting arms and armor, performing research, or spending their hard-earned gold.

In some cases, the passage of time is something that occurs with little fanfare or description. When starting a new adventure, the GM might simply declare that a certain amount of time has passed and allow you to describe in general terms what your character has been doing. At other times, the GM might want to keep track of just how much time is passing as events beyond your perception stay in motion.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-1', 'srd', NULL, 'Between Adventures (2)', '### Lifestyle Expenses

Between adventures, you choose a particular quality of life and pay the cost of maintaining that lifestyle.

Living a particular lifestyle doesn''t have a huge effect on your character, but your lifestyle can affect the way other individuals and groups react to you. For example, when you lead an aristocratic lifestyle, it might be easier for you to influence the nobles of the city than if you live in poverty.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-2', 'srd', NULL, 'Between Adventures (3)', '### Downtime Activities

Between adventures, the GM might ask you what your character is doing during his or her downtime. Periods of downtime can vary in duration, but each downtime activity requires a certain number of days to complete before you gain any benefit, and at least 8 hours of each day must be spent on the downtime activity for the day to count. The days do not need to be consecutive. If you have more than the minimum amount of days to spend, you can keep doing the same thing for a longer period of time, or switch to a new downtime activity.

Downtime activities other than the ones presented below are possible. If you want your character to spend his or her downtime performing an activity not covered here, discuss it with your GM.

#### Crafting

You can craft nonmagical objects, including adventuring equipment and works of art. You must be proficient with tools related to the object you are trying to create (typically artisan''s tools). You might also need access to special materials or locations necessary to create it. For example, someone proficient with smith''s tools needs a forge in order to craft a sword or suit of armor.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-3', 'srd', NULL, 'Between Adventures (4)', 'For every day of downtime you spend crafting, you can craft one or more items with a total market value not exceeding 5 gp, and you must expend raw materials worth half the total market value. If something you want to craft has a market value greater than 5 gp, you make progress every day in 5-gp increments until you reach the market value of the item. For example, a suit of plate armor (market value 1,500 gp) takes 300 days to craft by yourself.

Multiple characters can combine their efforts toward the crafting of a single item, provided that the characters all have proficiency with the requisite tools and are working together in the same place. Each character contributes 5 gp worth of effort for every day spent helping to craft the item. For example, three characters with the requisite tool proficiency and the proper facilities can craft a suit of plate armor in 100 days, at a total cost of 750 gp.

While crafting, you can maintain a modest lifestyle without having to pay 1 gp per day, or a comfortable lifestyle at half the normal cost.

#### Practicing a Profession

You can work between adventures, allowing you to maintain a modest lifestyle without having to pay 1 gp per day. This benefit lasts as long you continue to practice your profession.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-4', 'srd', NULL, 'Between Adventures (5)', 'If you are a member of an organization that can provide gainful employment, such as a temple or a thieves'' guild, you earn enough to support a comfortable lifestyle instead.

If you have proficiency in the Performance skill and put your performance skill to use during your downtime, you earn enough to support a wealthy lifestyle instead.

#### Recuperating

You can use downtime between adventures to recover from a debilitating injury, disease, or poison.

After three days of downtime spent recuperating, you can make a DC 15 Constitution saving throw. On a successful save, you can choose one of the following results:
- End one effect on you that prevents you from regaining hit points.
- For the next 24 hours, gain advantage on saving throws against one disease or poison currently affecting you.

#### Researching

The time between adventures is a great chance to perform research, gaining insight into mysteries that have unfurled over the course of the campaign. Research can include poring over dusty tomes and crumbling scrolls in a library or buying drinks for the locals to pry rumors and gossip from their lips.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-between-adventures-5', 'srd', NULL, 'Between Adventures (6)', 'When you begin your research, the GM determines whether the information is available, how many days of downtime it will take to find it, and whether there are any restrictions on your research (such as needing to seek out a specific individual, tome, or location). The GM might also require you to make one or more ability checks, such as an Intelligence (Investigation) check to find clues pointing toward the information you seek, or a Charisma (Persuasion) check to secure someone''s aid. Once those conditions are met, you learn the information if it is available.

For each day of research, you must spend 1 gp to cover your expenses. This cost is in addition to your normal lifestyle expenses.

#### Training

You can spend time between adventures learning a new language or training with a set of tools. Your GM might allow additional training options.

First, you must find an instructor willing to teach you. The GM determines how long it takes, and whether one or more ability checks are required.

The training lasts for 250 days and costs 1 gp per day. After you spend the requisite amount of time and money, you learn the new language or gain proficiency with the new tool.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-0', 'srd', NULL, 'What Is a Spell? (1)', '## What Is a Spell?

A spell is a discrete magical effect, a single shaping of the magical energies that suffuse the multiverse into a specific, limited expression. In casting a spell, a character carefully plucks at the invisible strands of raw magic suffusing the world, pins them in place in a particular pattern, sets them vibrating in a specific way, and then releases them to unleash the desired effect-in most cases, all in the span of seconds.

Spells can be versatile tools, weapons, or protective wards. They can deal damage or undo it, impose or remove conditions (see appendix PH-A), drain life energy away, and restore life to the dead.

Uncounted thousands of spells have been created over the course of the multiverse''s history, and many of them are long forgotten. Some might yet lie recorded in crumbling spellbooks hidden in ancient ruins or trapped in the minds of dead gods. Or they might someday be reinvented by a character who has amassed enough power and wisdom to do so.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-1', 'srd', NULL, 'What Is a Spell? (2)', '### Spell Level

Every spell has a level from 0 to 9. A spell''s level is a general indicator of how powerful it is, with the lowly (but still impressive) *magic missile* at 1st level and the earth-shaking *wish* at 9th. Cantrips-simple but powerful spells that characters can cast almost by rote-are level 0. The higher a spell''s level, the higher level a spellcaster must be to use that spell.

Spell level and character level don''t correspond directly. Typically, a character has to be at least 17th level, not 9th level, to cast a 9th-level spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-2', 'srd', NULL, 'What Is a Spell? (3)', '### Known and Prepared Spells

Before a spellcaster can use a spell, he or she must have the spell firmly fixed in mind, or must have access to the spell in a magic item. Members of a few classes, including bards and sorcerers, have a limited list of spells they know that are always fixed in mind. The same thing is true of many magic-using monsters. Other spellcasters, such as clerics and wizards, undergo a process of preparing spells. This process varies for different classes, as detailed in their descriptions.

In every case, the number of spells a caster can have fixed in mind at any given time depends on the character''s level.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-3', 'srd', NULL, 'What Is a Spell? (4)', '### Spell Slots

Regardless of how many spells a caster knows or prepares, he or she can cast only a limited number of spells before resting. Manipulating the fabric of magic and channeling its energy into even a simple spell is physically and mentally taxing, and higher-level spells are even more so. Thus, each spellcasting class''s description (except that of the warlock) includes a table showing how many spell slots of each spell level a character can use at each character level. For example, the 3rd-level wizard Umara has four 1st-level spell slots and two 2nd-level slots.

When a character casts a spell, he or she expends a slot of that spell''s level or higher, effectively "filling" a slot with the spell. You can think of a spell slot as a groove of a certain size-small for a 1st-level slot, larger for a spell of higher level. A 1st-level spell fits into a slot of any size, but a 9th-level spell fits only in a 9th-level slot. So when Umara casts *magic missile,* a 1st-level spell, she spends one of her four 1st-level slots and has three remaining.

Finishing a long rest restores any expended spell slots.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-4', 'srd', NULL, 'What Is a Spell? (5)', 'Some characters and monsters have special abilities that let them cast spells without using spell slots. For example, a monk who follows the Way of the Four Elements, a warlock who chooses certain eldritch invocations, and a pit fiend from the Nine Hells can all cast spells in such a way.

#### Casting a Spell at a Higher Level

When a spellcaster casts a spell using a slot that is of a higher level than the spell, the spell assumes the higher level for that casting. For instance, if Umara casts *magic missile* using one of her 2nd-level slots, that *magic missile* is 2nd level. Effectively, the spell expands to fill the slot it is put into.

Some spells, such as *magic missile* and *cure wounds*, have more powerful effects when cast at a higher level, as detailed in a spell''s description.

#### Casting in Armor

Because of the mental focus and precise gestures required for spellcasting, you must be proficient with the armor you are wearing to cast a spell. You are otherwise too distracted and physically hampered by your armor for spellcasting.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-5', 'srd', NULL, 'What Is a Spell? (6)', '### Cantrips

A cantrip is a spell that can be cast at will, without using a spell slot and without being prepared in advance. Repeated practice has fixed the spell in the caster''s mind and infused the caster with the magic needed to produce the effect over and over. A cantrip''s spell level is 0.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-what-is-a-spell-6', 'srd', NULL, 'What Is a Spell? (7)', '### Rituals

Certain spells have a special tag: ritual. Such a spell can be cast following the normal rules for spellcasting, or the spell can be cast as a ritual. The ritual version of a spell takes 10 minutes longer to cast than normal. It also doesn''t expend a spell slot, which means the ritual version of a spell can''t be cast at a higher level.

To cast a spell as a ritual, a spellcaster must have a feature that grants the ability to do so. The cleric and the druid, for example, have such a feature. The caster must also have the spell prepared or on his or her list of spells known, unless the character''s ritual feature specifies otherwise, as the wizard''s does.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-0', 'srd', NULL, 'Casting a Spell (1)', '## Casting a Spell

When a character casts any spell, the same basic rules are followed, regardless of the character''s class or the spell''s effects.

Each spell description begins with a block of information, including the spell''s name, level, school of magic, casting time, range, components, and duration. The rest of a spell entry describes the spell''s effect.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-1', 'srd', NULL, 'Casting a Spell (2)', '### Casting Time

Most spells require a single action to cast, but some spells require a bonus action, a reaction, or much more time to cast.

#### Bonus Action

A spell cast with a bonus action is especially swift. You must use a bonus action on your turn to cast the spell, provided that you haven''t already taken a bonus action this turn. You can''t cast another spell during the same turn, except for a cantrip with a casting time of 1 action.

#### Reactions

Some spells can be cast as reactions. These spells take a fraction of a second to bring about and are cast in response to some event. If a spell can be cast as a reaction, the spell description tells you exactly when you can do so.

#### Longer Casting Times

Certain spells (including spells cast as rituals) require more time to cast: minutes or even hours. When you cast a spell with a casting time longer than a single action or reaction, you must spend your action each turn casting the spell, and you must maintain your concentration while you do so (see "Concentration" below). If your concentration is broken, the spell fails, but you don''t expend a spell slot. If you want to try casting the spell again, you must start over.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-2', 'srd', NULL, 'Casting a Spell (3)', '### Spell Range

The target of a spell must be within the spell''s range. For a spell like *magic missile*, the target is a creature. For a spell like *fireball*, the target is the point in space where the ball of fire erupts.

Most spells have ranges expressed in feet. Some spells can target only a creature (including you) that you touch. Other spells, such as the *shield* spell, affect only you. These spells have a range of self.

Spells that create cones or lines of effect that originate from you also have a range of self, indicating that the origin point of the spell''s effect must be you (see "Areas of Effect" later in the this chapter).

Once a spell is cast, its effects aren''t limited by its range, unless the spell''s description says otherwise.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-3', 'srd', NULL, 'Casting a Spell (4)', '### Components

A spell''s components are the physical requirements you must meet in order to cast it. Each spell''s description indicates whether it requires verbal (V), somatic (S), or material (M) components. If you can''t provide one or more of a spell''s components, you are unable to cast the spell.

#### Verbal (V)

Most spells require the chanting of mystic words. The words themselves aren''t the source of the spell''s power; rather, the particular combination of sounds, with specific pitch and resonance, sets the threads of magic in motion. Thus, a character who is gagged or in an area of silence, such as one created by the *silence* spell, can''t cast a spell with a verbal component.

#### Somatic (S)

Spellcasting gestures might include a forceful gesticulation or an intricate set of gestures. If a spell requires a somatic component, the caster must have free use of at least one hand to perform these gestures.

#### Material (M)

Casting some spells requires particular objects, specified in parentheses in the component entry. A character can use a **component pouch** or a **spellcasting focus** (found in "Equipment") in place of the components specified for a spell. But if a cost is indicated for a component, a character must have that specific component before he or she can cast the spell.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-4', 'srd', NULL, 'Casting a Spell (5)', 'If a spell states that a material component is consumed by the spell, the caster must provide this component for each casting of the spell.

A spellcaster must have a hand free to access a spell''s material components-or to hold a spellcasting focus-but it can be the same hand that he or she uses to perform somatic components.', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-5', 'srd', NULL, 'Casting a Spell (6)', '### Duration

A spell''s duration is the length of time the spell persists. A duration can be expressed in rounds, minutes, hours, or even years. Some spells specify that their effects last until the spells are dispelled or destroyed.

#### Instantaneous

Many spells are instantaneous. The spell harms, heals, creates, or alters a creature or an object in a way that can''t be dispelled, because its magic exists only for an instant.

#### Concentration

Some spells require you to maintain concentration in order to keep their magic active. If you lose concentration, such a spell ends.

If a spell must be maintained with concentration, that fact appears in its Duration entry, and the spell specifies how long you can concentrate on it. You can end concentration at any time (no action required).', 0);
INSERT INTO lore_chunks (id, source, note_id, title, body, indexed) VALUES ('rule-casting-a-spell-6', 'srd', NULL, 'Casting a Spell (7)', 'Normal activity, such as moving and attacking, doesn''t interfere with concentration. The following factors can break concentration:
- **Casting another spell that requires concentration.** You lose concentration on a spell if you cast another spell that requires concentration. You can''t concentrate on two spells at once.
- **Taking damage.** Whenever you take damage while you are concentrating on a spell, you must make a Constitution saving throw to maintain your concentration. The DC equals 10 or half the damage you take, whichever number is higher. If you take damage from multiple sources, such as an arrow and a dragon''s breath, you make a separate saving throw for each source of damage.
- **Being incapacitated or killed.** You lose concentration on a spell if you are incapacitated or if you die.

The GM might also decide that certain environmental phenomena, such as a wave crashing over you while you''re on a storm-tossed ship, require you to succeed on a DC 10 Constitution saving throw to maintain concentration on a spell.', 0);
