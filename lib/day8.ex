defmodule Aoc2022.Day8 do
  @moduledoc """
  Documentation for `Day 8`.
  
  --- Day 8: Treetop Tree House ---
  https://adventofcode.com/2022/day/8
  
  """

  defmodule Tree do
    defstruct height: nil, visible: false
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

    visible_edges =
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
              # IO.inspect(%{{row, column} => current})

              left =
                (column - 1)..0
                |> Enum.map(fn x ->
                  %{height: u, visible: _v} = Map.get(trees, {row, x})

                  u
                end)
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              # IO.inspect(left)

              right =
                (column + 1)..col_count
                |> Enum.map(fn x ->
                  %{height: d, visible: _v} = Map.get(trees, {row, x})
                  d
                end)
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              # IO.inspect(right)

              up =
                (row - 1)..0
                |> Enum.map(fn x ->
                  %{height: l, visible: _v} = Map.get(trees, {x, column})
                  l
                end)
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              # IO.inspect(up)

              down =
                (row + 1)..row_count
                |> Enum.map(fn x ->
                  %{height: r, visible: _v} = Map.get(trees, {x, column})
                  r
                end)
                |> Enum.filter(fn x -> current <= x end)
                |> Enum.empty?()

              # IO.inspect(down)

              %{{i, j} => %Tree{height: current, visible: up || down || left || right}}
          end
        end)
      end)
      |> List.flatten()
      |> Enum.reduce(%{}, fn w, acc ->
        Map.merge(w, acc)
      end)

    visible_edges
    |> Enum.filter(fn {_, %{height: _, visible: v}} -> v end)
    |> Enum.count()
  end
end
