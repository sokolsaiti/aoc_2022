defmodule Aoc2022Test do
  use ExUnit.Case
  alias Aoc2022.Day1

  test "Day 1 - Step 1" do
    %{max: m, top3: _} = Day1.process_input()
    assert m == 68775
  end

  test "Day 1 - Step 2" do
    %{max: _, top3: t} = Day1.process_input()
    assert t == 202_585
  end
end
