defmodule Aoc2022.Day5 do
  def process_input do
    {:ok, content} = File.read("./input/day5.txt")

    [initial_state_content, instructions] =
    content
    |> String.split("\n\n")

    {buckets_row, stacks} =
    initial_state_content
    |> String.split("\n")
    |> Enum.reverse()
    |> List.pop_at(0)

    stack_buckets =
    buckets_row
    |> String.split(" ",trim: true)
    |> Map.new(fn x -> {x,[]} end)

    stack_buckets

  end
end
