defmodule Aoc2022.Day5 do
  def process_input do
    {:ok, content} = File.read("./input/day5.txt")

    [initial_state_content, instructions] =
      content
      |> String.split("\r\n\r\n")

    {_, stacks} =
      initial_state_content
      |> String.split("\r\n")
      |> Enum.reverse()
      |> List.pop_at(0)

    parsed_stacks =
      stacks
      |> Enum.map(fn x ->
        parse_row(x, [])
      end)
      |> List.zip()
      |> Enum.map(fn x -> Tuple.to_list(x) |> List.delete("") end)
      |> Enum.map(fn x -> x |> Enum.filter(fn y -> y != "" end) end)

    parsed_instructions =
      instructions
      |> String.split("\r\n")
      |> Enum.map(&parse_instruction/1)

    move(parsed_instructions, parsed_stacks)
    move_n(parsed_instructions, parsed_stacks)
  end

  defp pick_stack(list_of_stacks, position) do
    {stack, _} = List.pop_at(list_of_stacks, position)
    stack
  end

  def move_n([], stacks) do
    stacks
  end

  def move_n(instructions, stacks) do
    {{count, from, to}, rest_of_instructions} = List.pop_at(instructions, 0)

    src = pick_stack(stacks, from - 1)

    dst = pick_stack(stacks, to - 1)

    {new_src, new_dst} = move_immediate(src, dst, count)
    inter_result = List.replace_at(stacks, to - 1, new_dst)
    result = List.replace_at(inter_result, from - 1, new_src)

    move_n(rest_of_instructions, result)
  end

  def move([], stacks) do
    stacks
  end

  def move(instructions, stacks) do
    {{count, from, to}, rest_of_instructions} = List.pop_at(instructions, 0)

    src = pick_stack(stacks, from - 1)

    dst = pick_stack(stacks, to - 1)

    {new_src, new_dst} = move_box(src, dst, count)
    inter_result = List.replace_at(stacks, to - 1, new_dst)
    result = List.replace_at(inter_result, from - 1, new_src)

    move(rest_of_instructions, result)
  end

  def move_immediate(from, to, count) do
    boxes = Enum.take(from, -1 * count)
    new_from = Enum.drop(from, -1 * count)
    {new_from, to ++ boxes}
  end

  def move_box(from, to, 0) do
    {from, to}
  end

  def move_box(from, to, count) when count > 0 do
    {box, rest} = List.pop_at(from, -1)
    new = List.insert_at(to, -1, box)
    move_box(rest, new, count - 1)
  end

  def parse_instruction(instruction) do
    %{"amount" => a, "from" => f, "to" => t} =
      Regex.named_captures(~r{move (?<amount>\d+) from (?<from>\d+) to (?<to>\d+)}, instruction)

    {String.to_integer(a), String.to_integer(f), String.to_integer(t)}
  end

  def parse_row("", acc) do
    Enum.reverse(acc)
    # acc
  end

  def parse_row(row, acc) do
    {col, rest} = String.split_at(row, 4)
    acc = add_2_list(String.trim(col), acc)

    parse_row(rest, acc)
  end

  defp add_2_list(item, list) do
    [item | list]
  end
end
