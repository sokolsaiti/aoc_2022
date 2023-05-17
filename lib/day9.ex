defmodule Aoc2022.Day9 do
  defstruct hy: 0, hx: 0, history: []

  def process_input do
    content =
      File.stream!("./input/day9.2.txt")
      |> Enum.map(fn x ->
        [direction, steps] = String.split(x)
        {direction, String.to_integer(steps)}
      end)
      |> Enum.reduce(%__MODULE__{}, fn {direction, steps}, acc ->
        move(direction, steps, acc)
      end)

    %{hx: _x, hy: _y, history: h} = content
    tail_knot = tail_follow(h)
    last_knot = knot_follow(tail_knot, 3)
    IO.inspect(last_knot)

    part1 =
      tail_knot
      |> Enum.uniq()
      |> Enum.count()

    part1
  end

  defp knot_follow(h, 0) do
    h
  end

  defp knot_follow(h, knot_no) when knot_no > -1 do
    #dbg(h)
    #dbg(knot_no)
    IO.inspect(h)
    knot = tail_follow(h)
    knot_follow(knot, knot_no - 1)
  end



  defp tail_follow(h) do
    Enum.reverse(h)
    |> Enum.reduce([%{hx: 0, hy: 0}], fn %{hx: hx, hy: hy}, [%{hx: x, hy: y} | _] = acc ->
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
          acc

        {1, -1} ->
          acc

        {-1, 1} ->
          acc

        {1, 1} ->
          acc

        {0, 2} ->
          [%{hx: x, hy: y + 1} | acc]

        {0, -2} ->
          [%{hx: x, hy: y - 1} | acc]

        {2, 0} ->
          [%{hx: x + 1, hy: y} | acc]

        {-2, 0} ->
          [%{hx: x - 1, hy: y} | acc]

        {2, 1} ->
          [%{hx: x + 1, hy: y + 1} | acc]

        {2, -1} ->
          [%{hx: x + 1, hy: y - 1} | acc]

        {-2, 1} ->
          [%{hx: x - 1, hy: y + 1} | acc]

        {-2, -1} ->
          [%{hx: x - 1, hy: y - 1} | acc]

        {1, 2} ->
          [%{hx: x + 1, hy: y + 1} | acc]

        {1, -2} ->
          [%{hx: x + 1, hy: y - 1} | acc]

        {-1, 2} ->
          [%{hx: x - 1, hy: y + 1} | acc]

        {-1, -2} ->
          [%{hx: x - 1, hy: y - 1} | acc]
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
