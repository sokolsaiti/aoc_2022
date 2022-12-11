defmodule Aoc2022Test do
  use ExUnit.Case
  alias Aoc2022.Day4
  alias Aoc2022.Day2
  alias Aoc2022.Day1
  alias Aoc2022.Day3

  test "Day 1 - Step 1" do
    %{max: m, top3: _} = Day1.process_input()
    assert m == 68775
  end

  test "Day 1 - Step 2" do
    %{max: _, top3: t} = Day1.process_input()
    assert t == 202_585
  end

  test "Day 2" do
    {part1, part2} = Day2.process_input()
    assert part1 == 13484
    assert part2 == 13433
  end

  test "Day 3" do
    {part1, part2} = Day3.process_input()
    assert part1 == 7850
    assert part2 == 2581
  end

  test "Day 4" do
    {part1, part2} = Day4.process_input()
    assert part1 == 571
    assert part2 == 917
  end
end
