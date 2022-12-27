defmodule Aoc2022.Day9 do
  defstruct hy: 0, hx: 0, history: [], tx: 0, ty: 0, thistory: []

  def process_input do
    content =
      File.stream!("./input/day9.txt")
      |> Enum.map(fn x ->
        [direction, steps] = String.split(x)
        {direction, String.to_integer(steps)}
      end)
      |> Enum.reduce(%__MODULE__{}, fn {direction, steps}, acc ->
        move(direction, steps, acc)
      end)

    %{hx: _x, hy: _y, history: h} = content

    part1 =
      tail_follow(h)
      |> Enum.uniq()
      |> Enum.count()

    part1
  end

  def tail_follow(h) do
    Enum.reverse(h)
    |> Enum.reduce([{0, 0}], fn %{hx: hx, hy: hy}, [{x, y} | _] = acc ->
      # diff = {abs(hx) - abs(x), abs(hy) - abs(y)}
      # {hx - x, hy - y} 4805, 5152, 5751
      # dbg()
      case {hx - x, hy - y} do
        {0, 0} ->
          acc

        {0, 1} ->
          acc

        {0, -1} ->
          acc

        {1, 0} ->
          acc

        {-1, 0} ->
          acc

        {-1, -1} ->
          # [{x - 1, y} | acc]
          acc

        {1, -1} ->
          # [{x + 1, y} | acc]
          acc

        {-1, 1} ->
          # [{x - 1, y} | acc]
          acc

        {1, 1} ->
          # [{x + 1, y} | acc]
          acc

        {0, 2} ->
          [{x, y + 1} | acc]

        {0, -2} ->
          [{x, y - 1} | acc]

        {2, 0} ->
          [{x + 1, y} | acc]

        {-2, 0} ->
          [{x - 1, y} | acc]

        {2, 1} ->
          [{x + 1, y + 1} | acc]

        {2, -1} ->
          [{x + 1, y - 1} | acc]

        {-2, 1} ->
          [{x - 1, y + 1} | acc]

        {-2, -1} ->
          [{x - 1, y - 1} | acc]

        {1, 2} ->
          [{x + 1, y + 1} | acc]

        {1, -2} ->
          [{x + 1, y - 1} | acc]

        {-1, 2} ->
          [{x - 1, y + 1} | acc]

        {-1, -2} ->
          [{x - 1, y - 1} | acc]
      end
    end)
  end

  defp move("D", steps, %__MODULE__{hy: n, hx: e, history: h}) do
    path = for step <- n..(n - steps), do: %{hy: step, hx: e}

    %__MODULE__{
      hy: n - steps,
      hx: e,
      history: Enum.reverse(path) ++ h
    }
  end

  defp move("U", steps, %__MODULE__{hy: n, hx: e, history: h}) do
    path = for step <- n..(n + steps), do: %{hy: step, hx: e}

    %__MODULE__{
      hy: n + steps,
      hx: e,
      history: Enum.reverse(path) ++ h
    }
  end

  defp move("L", steps, %__MODULE__{hy: n, hx: e, history: h}) do
    path = for step <- e..(e - steps), do: %{hy: n, hx: step}

    %__MODULE__{
      hy: n,
      hx: e - steps,
      history: Enum.reverse(path) ++ h
    }
  end

  defp move("R", steps, %__MODULE__{hy: n, hx: e, history: h}) do
    path = for step <- e..(e + steps), do: %{hy: n, hx: step}

    %__MODULE__{
      hy: n,
      hx: e + steps,
      history: Enum.reverse(path) ++ h
    }
  end
end
