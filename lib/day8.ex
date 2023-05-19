defmodule Aoc2022.Day8 do
  @moduledoc """
  Documentation for `Day 8`.
  
  --- Day 8: Treetop Tree House ---
  https://adventofcode.com/2022/day/8
  
  """

  defmodule Tree do
    defstruct height: nil, visible: false, score: 1
  end

  def process_input do
    rows =
      File.read!("./input/day8.txt")
      |> String.split("\r\n")

    row_count = Enum.count(rows) - 1
    cols = rows |> Enum.at(0) |> String.graphemes()
    col_count = Enum.count(cols) - 1

    trees =
      rows
      |> Enum.with_index()
      |> Enum.map(fn {x, i} ->
        t =
          x
          |> String.graphemes()
          |> Enum.with_index()
          |> Enum.reduce(%{}, fn {y, j}, acc ->
            Map.put(acc, {i, j}, %Tree{height: String.to_integer(y), visible: false})
          end)

        t
      end)
      |> Enum.reduce(%{}, fn x, acc ->
        Map.merge(acc, x)
      end)

    trees_with_visibility =
      0..row_count
      |> Enum.map(fn i ->
        0..col_count
        |> Enum.map(fn j ->
          case {i, j} do
            {0, _} ->
              tree = Map.get(trees, {i, j})
              %{{i, j} => %Tree{tree | visible: true}}

            {_, 0} ->
              tree = Map.get(trees, {i, j})
              %{{i, j} => %Tree{tree | visible: true}}

            {r, _} when r == row_count ->
              tree = Map.get(trees, {i, j})
              %{{i, j} => %Tree{tree | visible: true}}

            {_, c} when c === col_count ->
              tree = Map.get(trees, {i, j})
              %{{i, j} => %Tree{tree | visible: true}}

            {r, c} when r == row_count and c == col_count ->
              tree = Map.get(trees, {i, j})
              %{{i, j} => %Tree{tree | visible: true}}

            {row, column} ->
              %{height: current, visible: _v} = Map.get(trees, {i, j})

              trees_left = traverse_x(trees, column - 1, 0, row)

              visibility_score_left =
                trees_left
                |> visibility_score(current)

              visible_left? =
                trees_left
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              trees_right = traverse_x(trees, column + 1, col_count, row)

              visibility_score_right =
                trees_right
                |> visibility_score(current)

              visible_right? =
                trees_right
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              trees_up = traverse_y(trees, row - 1, 0, column)

              visibility_score_up =
                trees_up
                |> visibility_score(current)

              visible_up? =
                trees_up
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              trees_down = traverse_y(trees, row + 1, row_count, column)

              visibility_score_down =
                trees_down
                |> visibility_score(current)

              visible_down? =
                trees_down
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              %{
                {i, j} => %Tree{
                  height: current,
                  visible: visible_up? || visible_down? || visible_left? || visible_right?,
                  score:
                    visibility_score_down * visibility_score_left * visibility_score_right *
                      visibility_score_up
                }
              }
          end
        end)
      end)
      |> List.flatten()
      |> Enum.reduce(%{}, fn w, acc ->
        Map.merge(w, acc)
      end)

    visible_count =
      trees_with_visibility
      |> Enum.filter(fn {_, %{height: _, visible: v}} -> v end)
      |> Enum.count()

    highest_score =
      trees_with_visibility
      |> Enum.map(fn {_, %{score: s}} -> s end)
      |> Enum.max()

    {visible_count, highest_score}
  end

  defp traverse_x(trees, from, to, axis) do
    from..to
    |> Enum.map(fn x ->
      %{height: u, visible: _v} = Map.get(trees, {axis, x})
      u
    end)
  end

  defp traverse_y(trees, from, to, axis) do
    from..to
    |> Enum.map(fn x ->
      %{height: u, visible: _v} = Map.get(trees, {x, axis})
      u
    end)
  end

  defp visibility_score(trees, current) do
    score =
      trees
      |> Enum.reduce_while(0, fn x, acc ->
        if x >= current, do: {:halt, acc + 1}, else: {:cont, acc + 1}
      end)

    score
  end
end
