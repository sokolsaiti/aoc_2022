defmodule Aoc2022.Day8 do
  defmodule Tree do
    defstruct height: nil, visible: false, score: []
  end

  def process_input do
    {:ok, raw} = File.read("./input/day8.txt")

    processed =
      raw
      |> String.trim()
      |> String.split()
      |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(fn x -> String.to_integer(x) end) end)

    Enum.with_index(processed)
  end
end
