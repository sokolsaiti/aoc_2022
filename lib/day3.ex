defmodule Aoc_2022.Day3 do
  def process_input do
    {:ok, content} = File.read("./input/day3.txt")

    rucksacks =
      content
      |> String.split("\n")
      |> Enum.map(fn x ->
        String.split_at(x, div(String.length(x), 2))
      end)
      |> Enum.map(fn {a, b} ->
        MapSet.intersection(MapSet.new(String.graphemes(a)), MapSet.new(String.graphemes(b)))
      end)

    rucksacks
  end
end
