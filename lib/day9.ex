defmodule Aoc2022.Day9 do
  defstruct north: 0, east: 0, history: []

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

    content
  end

  def move("D", steps, %__MODULE__{north: n, east: e, history: h} = rope) do
    path = for x <- n..(n - steps), do: %{north: x, east: e}

    %__MODULE__{
      north: n - steps,
      east: e,
      history: Enum.drop(Enum.reverse(Enum.drop(path, 1)), 1) ++ h
    }
  end

  def move("U", steps, %__MODULE__{north: n, east: e, history: h} = rope) do
    path = for x <- n..(n + steps), do: %{north: x, east: e}

    %__MODULE__{
      north: n + steps,
      east: e,
      history: Enum.drop(Enum.reverse(Enum.drop(path, 1)), 1) ++ h
    }
  end

  def move("L", steps, %__MODULE__{north: n, east: e, history: h} = rope) do
    path = for x <- e..(e - steps), do: %{north: n, east: x}

    %__MODULE__{
      north: n,
      east: e - steps,
      history: Enum.drop(Enum.reverse(Enum.drop(path, 1)), 1) ++ h
    }
  end

  def move("R", steps, %__MODULE__{north: n, east: e, history: h} = rope) do
    path = for x <- e..(e + steps), do: %{north: n, east: x}

    %__MODULE__{
      north: n,
      east: e + steps,
      history: Enum.drop(Enum.reverse(Enum.drop(path, 1)), 1) ++ h
    }
  end
end
