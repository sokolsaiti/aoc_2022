defmodule Aoc2022.Day6 do
  @moduledoc """
  Documentation for `Day 6`.

  --- Day 4: Camp Cleanup ---

  https://adventofcode.com/2022/day/6

  """

  def process_input do
    {:ok, content} = File.read("./input/day6.txt")

    first_four = String.slice(content, 0..3) |> String.graphemes()

    {_, rest} = String.split_at(content, 4)

    part1 = process_by_char(String.graphemes(rest), first_four, Enum.uniq(first_four), 4)

    {_, part2_rest} = String.split_at(content, 14)

    # dbg()

    part2 =
      part2_process_by_char(
        part2_rest |> String.graphemes(),
        String.slice(content, 0..13) |> String.graphemes(),
        String.slice(content, 0..13) |> String.graphemes() |> Enum.uniq() |> length,
        14
      )

    {part1, part2}
  end

  def process_by_char(_, _, 4, acc) do
    {:part1, acc}
  end

  def process_by_char([h | t], buffer, unique_chars, acc) do
    {_, rest} = List.pop_at(buffer, 0)
    n = List.insert_at(rest, -1, h)
    process_by_char(t, n, length(Enum.uniq(n)), acc + 1)
  end

  def part2_process_by_char(_, _, 14, acc) do
    {:part2, acc}
  end

  def part2_process_by_char([h | t], buffer, unique_chars, acc) do
    {_, rest} = List.pop_at(buffer, 0)
    n = List.insert_at(rest, -1, h)
    part2_process_by_char(t, n, length(Enum.uniq(n)), acc + 1)
  end
end
