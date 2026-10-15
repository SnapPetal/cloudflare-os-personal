import { describe, expect, it } from "vitest";
import {
  abilityModifier,
  critExpression,
  describeRoll,
  parseDice,
  rollDice,
  rollDie,
  rollExpression,
  scriptedSource,
} from "../src/dice";

describe("dice", () => {
  it("maps uint32 values onto 1..sides", () => {
    expect(rollDie(20, scriptedSource([0]))).toBe(1);
    expect(rollDie(20, scriptedSource([19]))).toBe(20);
    expect(rollDie(6, scriptedSource([5]))).toBe(6);
  });

  it("rejects biased values and draws again", () => {
    const limit = Math.floor(0x1_0000_0000 / 20) * 20;
    expect(rollDie(20, scriptedSource([limit, 4]))).toBe(5);
  });

  it("rolls advantage and disadvantage on a d20", () => {
    const advantage = rollDice({ count: 1, sides: 20, modifier: 2, mode: "advantage" }, scriptedSource([19, 3]));
    expect(advantage.kept).toEqual([20]);
    expect(advantage.dropped).toEqual([4]);
    expect(advantage.total).toBe(22);
    expect(advantage.critical).toBe(true);

    const disadvantage = rollDice(
      { count: 1, sides: 20, modifier: 0, mode: "disadvantage" },
      scriptedSource([19, 3]),
    );
    expect(disadvantage.kept).toEqual([4]);
    expect(disadvantage.dropped).toEqual([20]);
    expect(disadvantage.fumble).toBe(false);
    expect(disadvantage.total).toBe(4);
  });

  it("drops nothing when both advantage dice match", () => {
    const roll = rollExpression("1d20+3", scriptedSource([7, 7]), "advantage");
    expect(roll.kept).toEqual([8]);
    expect(roll.dropped).toEqual([]);
    expect(roll.total).toBe(11);
    expect(describeRoll(roll)).toContain("Total 11");
  });

  it("refuses advantage on anything except a single d20", () => {
    expect(() => rollDice({ count: 2, sides: 6, modifier: 0, mode: "advantage" }, scriptedSource([1, 1]))).toThrow(
      /single d20/,
    );
  });

  it("parses notation and doubles dice on a crit without doubling the modifier", () => {
    expect(parseDice("d8")).toEqual({ count: 1, sides: 8, modifier: 0 });
    expect(parseDice("2d6+1")).toEqual({ count: 2, sides: 6, modifier: 1 });
    expect(parseDice("1d20-1")).toEqual({ count: 1, sides: 20, modifier: -1 });
    expect(critExpression("1d8+2")).toBe("2d8+2");
    expect(() => parseDice("3d7+1")).toThrow(/d4/);
  });

  it("flags a natural 1 and a natural 20", () => {
    const fumble = rollExpression("1d20+5", scriptedSource([0]));
    const crit = rollExpression("1d20", scriptedSource([19]));
    expect(fumble.fumble).toBe(true);
    expect(fumble.total).toBe(6);
    expect(crit.critical).toBe(true);
    expect(crit.natural).toBe(20);
  });

  it("computes ability modifiers", () => {
    expect(abilityModifier(10)).toBe(0);
    expect(abilityModifier(8)).toBe(-1);
    expect(abilityModifier(15)).toBe(2);
    expect(() => abilityModifier(10.5)).toThrow(/whole number/);
  });
});
