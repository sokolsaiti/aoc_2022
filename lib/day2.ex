defmodule Aoc2022.Day2 do
  @moduledoc """
  Documentation for `Day2`.
  
  --- Day 2: Rock Paper Scissors ---
  
  https://adventofcode.com/2022/day/2
  
  """

  def process_input do
    {:ok, content} = File.read("./input/day2.txt")

    guides =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        translate(x)
      end)
      |> Enum.map(fn x -> %{x | result: who_won?(x)} end)
      |> Enum.map(fn %{:m => _, :o => _, :result => r, :shape_value => v} -> r + v end)
      |> Enum.sum()

    guides
  end

  def who_won?(%{m: :scissors, o: :paper}) do
    6
  end

  def who_won?(%{m: :paper, o: :rock}) do
    6
  end

  def who_won?(%{m: :rock, o: :scissors}) do
    6
  end

  def who_won?(%{m: me, o: other}) when me == other do
    3
  end

  def who_won?(%{m: _, o: _}) do
    0
  end

  def translate(guide) do
    [first, second] = String.split(guide, " ")

    %{
      o: translate_input(first),
      m: translate_input(second),
      result: 0,
      shape_value: get_value(translate_input(second))
    }
  end

  defp get_value(:rock) do
    1
  end

  defp get_value(:paper) do
    2
  end

  defp get_value(:scissors) do
    3
  end

  defp translate_input("A") do
    :rock
  end

  defp translate_input("B") do
    :paper
  end

  defp translate_input("C") do
    :scissors
  end

  defp translate_input("X") do
    translate_input("A")
  end

  defp translate_input("Y") do
    translate_input("B")
  end

  defp translate_input("Z") do
    translate_input("C")
  end
end
