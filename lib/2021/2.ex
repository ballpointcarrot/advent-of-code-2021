import AOC

aoc 2021, 2 do
  def action(line) do
    [direction, length] = String.split(line, " ")
    [direction, String.to_integer(length)]
  end

  def drive_sub([direction, distance], [forward, depth]) do
    case direction do
      "forward" -> [forward + distance, depth]
      "up" -> [forward, depth - distance]
      "down" -> [forward, depth + distance]
    end
  end

  def drive_sub_nose([direction, distance], [forward, depth, aim]) do
    case direction do
      "forward" -> [forward + distance, depth + distance * aim, aim]
      "up" -> [forward, depth, aim - distance]
      "down" -> [forward, depth, aim + distance]
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
