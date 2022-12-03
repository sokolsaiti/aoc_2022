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
        translate(x, :all)
      end)
      |> Enum.map(fn x -> %{x | result: who_won?(x)} end)
      |> Enum.map(fn %{:m => _, :o => _, :result => r, :shape_value => v} -> r + v end)
      |> Enum.sum()

    step2_result =
      content
      |> String.split("\r\n")
      |> Enum.map(fn x ->
        translate(x, :oponent_only)
      end)
      |> Enum.map(fn x ->
        {:ok, oponent_shape} = Map.fetch(x, :o)
        {:ok, my_instruction} = Map.fetch(x, :m)
        IO.inspect(x)
        y = %{x | m: transform_my_shape(oponent_shape, my_instruction)}
        IO.inspect(y)
        %{y | shape_value: get_value(transform_my_shape(oponent_shape, my_instruction))}
      end)
      |> Enum.map(fn x -> %{x | result: who_won?(x)} end)
      |> IO.inspect()
      |> Enum.map(fn %{:m => _, :o => _, :result => r, :shape_value => v} -> r + v end)
      |> Enum.filter(fn %{:m => me, :o => oponent, :result => r, :shape_value => v} ->
        me == oponent
      end)

    # |> Enum.sum()

    step2_result
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

  def translate(guide, :all) do
    [oponent, me] = String.split(guide, " ")

    %{
      o: translate_input(oponent),
      m: translate_input(me),
      result: 0,
      shape_value: get_value(translate_input(me)),
      original_shape: translate_input(me),
      instruction: me
    }
  end

  def translate(guide, :oponent_only) do
    [oponent, me] = String.split(guide, " ")

    %{
      o: translate_input(oponent),
      m: me,
      result: 0,
      shape_value: get_value(translate_input(me)),
      original_shape: translate_input(me),
      instruction: me
    }
  end

  # draw
  def transform_my_shape(oponent, "Y") do
    oponent
  end

  # loose
  def transform_my_shape(oponent, "X") do
    lose(oponent)
  end

  # win
  def transform_my_shape(oponent, "Z") do
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
    :scissors
  end

  defp lose(:rock) do
    :paper
  end

  defp lose(:scissors) do
    :rock
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
