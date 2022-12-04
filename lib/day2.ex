defmodule Aoc2022.Day2 do
  @moduledoc """
  Documentation for `Day2`.
  
  --- Day 2: Rock Paper Scissors ---
  
  https://adventofcode.com/2022/day/2
  
  """

  def process_input do
    {:ok, content} = File.read("./input/day2.txt")

    step1_result =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        translate(x)
      end)
      |> Enum.map(fn x ->
        {:ok, me} = Map.fetch(x, :m)
        who_won?(x) + get_value(me)
      end)
      |> Enum.sum()

    step2_result =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        translate(x)
      end)
      |> Enum.map(fn x ->
        {:ok, oponent} = Map.fetch(x, :o)
        {:ok, instruction} = Map.fetch(x, :instruction)

        who_won?(%{m: strategy(oponent, instruction), o: oponent}) +
          get_value(strategy(oponent, instruction))
      end)
      |> Enum.sum()

    {step1_result, step2_result}
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
    [oponent, me] = String.split(guide, " ")

    %{
      o: translate_input(oponent),
      m: translate_input(me),
      result: 0,
      shape_value: get_value(translate_input(me)),
      instruction: me
    }
  end

  # draw
  def strategy(oponent, "Y") do
    oponent
  end

  # lose
  def strategy(oponent, "X") do
    lose(oponent)
  end

  # win
  def strategy(oponent, "Z") do
    win(oponent)
  end

  defp win(:paper) do
    :scissors
  end

  defp win(:rock) do
    :paper
  end

  defp win(:scissors) do
    :rock
  end

  defp lose(:paper) do
    :rock
  end

  defp lose(:rock) do
    :scissors
  end

  defp lose(:scissors) do
    :paper
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
