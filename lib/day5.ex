defmodule Aoc2022.Day5 do
  def process_input do
    {:ok, content} = File.read("./input/day5.txt")

    [initial_state_content, instructions] =
    content
    |> String.split("\r\n\r\n")

    initial_state =
    initial_state_content
    |> String.split("\r\n")
    |> Enum.map()

    initial_state
  end
end
