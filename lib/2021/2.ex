import AOC

aoc 2021, 2 do
  def action(line) do
    [direction, magnitude] = String.split(line, " ")
    [direction, String.to_integer(magnitude)]
  end

  def drive_sub([direction, magnitude], [forward, depth]) do
    case direction do
      "forward" -> [forward + magnitude, depth]
      "up" -> [forward, depth - magnitude]
      "down" -> [forward, depth + magnitude]
    end
  end

  def drive_sub_nose([direction, magnitude], [forward, depth, aim]) do
    case direction do
      "forward" -> [forward + magnitude, depth + magnitude * aim, aim]
      "up" -> [forward, depth, aim - magnitude]
      "down" -> [forward, depth, aim + magnitude]
    end
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    components =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&action/1)
      |> Enum.reduce([0, 0], &drive_sub/2)

    IO.inspect(components)
    Enum.product(components)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    components =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&action/1)
      |> Enum.reduce([0, 0, 0], &drive_sub_nose/2)

    IO.inspect(Enum.drop(components, -1))

    Enum.product(Enum.drop(components, -1))
  end
end
