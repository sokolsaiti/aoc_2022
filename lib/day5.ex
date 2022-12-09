defmodule Aoc2022.Day5 do
  def process_input do
    {:ok, content} = File.read("./input/day5.txt")

    [initial_state_content, instructions] =
      content
      |> String.split("\r\n\r\n")

    {buckets_row, stacks} =
      initial_state_content
      |> String.split("\r\n")
      |> Enum.reverse()
      |> List.pop_at(0)

    parsed_instructions =
      instructions
      |> String.split("\r\n")

    stack_buckets =
      buckets_row
      |> String.split(" ", trim: true)
      |> Map.new(fn x -> {String.to_integer(x), []} end)

    parsed_stacks =
      stacks
      |> Enum.map(fn x ->
        parse_row(x, [])
      end)
      |> List.zip()
      |> Enum.map(fn x -> Tuple.to_list(x) |> List.delete("") end)
      |> Enum.map(fn x -> x |> Enum.filter(fn y -> y != "" end) end)

    parsed_instructions
  end

  def parse_row("", acc) do
    Enum.reverse(acc)
    # acc
  end

  def parse_instruction(instruction) do
    %{"amount" => a, "from" => f, "to" => t} =
      Regex.named_captures(~r{move (?<amount>\d+) from (?<from>\d+) to (?<to>\d+)}, instruction)

    {String.to_integer(a), String.to_integer(f), String.to_integer(t)}
  end

  def parse_row(row, acc) do
    {col, rest} = String.split_at(row, 4)
    acc = add_2_list(String.trim(col), acc)

    parse_row(rest, acc)
  end

  def move_out(list) do
    List.pop_at(list, -1)
  end

  def move_in(list, box) do
    List.insert_at(list, -1, box)
  end

  defp add_2_list(item, list) do
    [item | list]
  end
end
