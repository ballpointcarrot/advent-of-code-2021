import AOC

aoc 2021, 2 do
  def action(line) do
    [direction, magnitude] = String.split(line, " ")
    [direction, String.to_integer(magnitude)]
  end

  def drive_sub([direction, magnitude], [forward, depth]) when direction == "forward",
    do: [forward + magnitude, depth]

  def drive_sub([direction, magnitude], [forward, depth]) when direction == "up",
    do: [forward, depth - magnitude]

  def drive_sub([direction, magnitude], [forward, depth]) when direction == "down",
    do: [forward, depth + magnitude]

  def drive_sub_nose([direction, magnitude], [forward, depth, aim]) when direction == "forward",
    do: [forward + magnitude, depth + magnitude * aim, aim]

  def drive_sub_nose([direction, magnitude], [forward, depth, aim]) when direction == "up",
    do: [forward, depth, aim - magnitude]

  def drive_sub_nose([direction, magnitude], [forward, depth, aim]) when direction == "down",
    do: [forward, depth, aim + magnitude]

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
