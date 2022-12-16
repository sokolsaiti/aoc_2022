defmodule Aoc2022.Day7 do
  @moduledoc """
  Documentation for `Day 7`.

  --- Day 7: No Space Left On Device ---

  https://adventofcode.com/2022/day/7

  """

  def process_input do
    {result, _} =
      File.stream!("./input/day7.txt")
      |> Enum.reduce({%{}, "/"}, fn cmd, {dirs, cwd} = acc ->
        case String.trim(cmd) do
          "$ ls" <> _ ->
            acc

          "dir" <> _ ->
            acc

          "$ cd .." ->
            new_wd = cwd |> Path.split() |> Enum.drop(-1) |> Path.join()
            {Map.update!(dirs, new_wd, &(&1 + Map.fetch!(dirs, cwd))), new_wd}

          "$ cd " <> new_dir ->
            new_cwd = Path.join(cwd, new_dir)
            dirs = Map.put(dirs, new_cwd, 0)
            {dirs, new_cwd}

          file ->
            size =
              file
              |> String.split(" ")
              |> List.first()
              |> String.to_integer()

            {Map.update!(dirs, cwd, &(&1 + size)), cwd}
        end
      end)

    result
    |> Enum.filter(fn {_, size} -> size <= 100_000 end)
    |> Enum.reduce(0, fn {_, size}, sum -> sum + size end)
  end
end
