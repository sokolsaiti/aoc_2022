defmodule Aoc2022.Day3 do
  def process_input do
    {:ok, content} = File.read("./input/day3.txt")

    items =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        String.split_at(x, div(String.length(x), 2))
      end)
      |> Enum.map(fn {a, b} ->
        MapSet.intersection(MapSet.new(String.graphemes(a)), MapSet.new(String.graphemes(b)))
        |> MapSet.to_list()
      end)
      |> List.flatten()
      |> Enum.map(fn x ->
        Enum.find_index(
          String.graphemes("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"),
          fn y -> y == x end
        ) + 1
      end)
      |> Enum.sum()

    common_items =
      content
      |> String.split("\r\n")
      |> Enum.chunk_every(3)
      |> Enum.map(fn [a, b, c] ->
        MapSet.intersection(MapSet.new(String.graphemes(a)), MapSet.new(String.graphemes(b)))
        |> MapSet.intersection(MapSet.new(String.graphemes(c)))
        |> MapSet.to_list()
      end)
      |> List.flatten()
      |> Enum.map(fn x ->
        Enum.find_index(
          String.graphemes("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"),
          fn y -> y == x end
        ) + 1
      end)
      |> Enum.sum()

    {items, common_items}
  end
end
