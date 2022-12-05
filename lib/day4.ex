defmodule Aoc2022.Day4 do
  @moduledoc """
  Documentation for `Day 4`.

  --- Day 4: Camp Cleanup ---

  https://adventofcode.com/2022/day/4

  """

  def process_input do
    {:ok, content} = File.read("./input/day4.txt")

    all_overlapping_tasks =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        String.split(x, ",")
        |> Enum.map(fn y ->
          [a, b] = String.split(y, "-")
          MapSet.new(String.to_integer(a)..String.to_integer(b))
        end)
      end)
      |> Enum.map(fn [a, b] ->
        if MapSet.subset?(a, b) or MapSet.subset?(b, a) do
          1
        else
          0
        end
      end)
      |> Enum.sum()

    some_overlapping_tasks =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        String.split(x, ",")
        |> Enum.map(fn y ->
          [a, b] = String.split(y, "-")
          MapSet.new(String.to_integer(a)..String.to_integer(b))
        end)
      end)
      |> Enum.map(fn [a, b] ->
        if MapSet.disjoint?(a, b) do
          0
        else
          1
        end
      end)
      |> Enum.sum()

    {all_overlapping_tasks, some_overlapping_tasks}
  end
end
