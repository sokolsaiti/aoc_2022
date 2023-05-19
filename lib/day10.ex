defmodule Aoc2022.Day10 do
  @moduledoc """
  Documentation for `Day 10`.
  
  --- Day 10: Cathode-Ray Tube ---
  https://adventofcode.com/2022/day/10
  
  """

  defmodule CPU do
    defstruct x: 1, cycle: 1
  end

  def process_input() do
    lines =
      File.read!("./input/day10.txt")
      |> String.split("\r\n")

    instructions =
      lines
      |> Enum.map(fn x -> parse(x) end)

    execution_cycles =
      instructions
      |> Enum.reduce([%CPU{}], fn x, acc ->
        {instr, operand} = x
        execute(instr, operand, acc)
      end)

    part_one =
      [20, 60, 100, 140, 180, 220]
      |> Enum.map(fn x ->
        %{x: value, cycle: cycle} =
          execution_cycles
          |> Enum.find(fn %{x: _, cycle: c} -> c == x end)

        value * cycle
      end)
      |> Enum.sum()

    part_one
  end

  defp execute(:noop, _, cpu) do
    [h | _] = cpu
    %{x: x, cycle: c} = h
    [%CPU{x: x, cycle: c + 1} | cpu]
  end

  defp execute(:addx, operand, cpu) do
    [h | _] = cpu
    %{x: x, cycle: c} = h
    t = [%CPU{x: x, cycle: c + 1} | cpu]
    [%CPU{x: x + operand, cycle: c + 1 + 1} | t]
  end

  defp parse("noop") do
    {:noop, 0}
  end

  defp parse("addx " <> operand) do
    {:addx, String.to_integer(operand)}
  end
end
