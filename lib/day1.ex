defmodule Aoc2022.Day1 do
  @moduledoc """
  Documentation for `Day1`.

  --- Day 1: Calorie Counting ---

  https://adventofcode.com/2022/day/1

  """

  def process_input do
    {:ok, content} = File.read("./input/day1.txt")

    input =
      content
      |> String.split("\r\n\r\n")
      |> Enum.map(fn x ->
        String.split(x, "\r\n")
        |> Enum.map(fn y -> String.to_integer(y) end)
      end)
      |> Enum.map(fn z -> Enum.sum(z) end)

    %{:max => max_calories(input), top3: top_3(input)}
  end

  defp top_3(input) do
    input
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp max_calories(input) do
    input
    |> Enum.max()
  end
end
