import AOC

aoc 2021, 7 do
  def minimum_fuel_position(crabs) do
    min = Enum.min(crabs)
    max = Enum.max(crabs)

    Enum.map(min..max, fn index ->
      fuel_used =
        Enum.reduce(crabs, fn crab, fuel ->
          fuel + abs(crab - index)
        end)

      {index, fuel_used}
    end)
    |> Enum.min_by(fn {_, v} -> v end)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    crabs =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    min_pos = minimum_fuel_position(crabs)

    Enum.reduce(crabs, 0, fn crab, fuel ->
      fuel + abs(crab - elem(min_pos, 0))
    end)
  end

  def minimum_fuel_position_crabby(crabs) do
    min = Enum.min(crabs)
    max = Enum.max(crabs)

    Enum.map(min..max, fn index ->
      fuel_used =
        Enum.reduce(crabs, 0, fn crab, fuel ->
          distance = abs(crab - index)
          fuel + Enum.sum(0..distance)
        end)

      {index, fuel_used}
    end)
    |> Enum.min_by(fn {_, v} -> v end)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    crabs =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    min_pos = minimum_fuel_position_crabby(crabs)

    Enum.reduce(crabs, 0, fn crab, fuel ->
      distance = abs(crab - elem(min_pos, 0))
      fuel + Enum.sum(0..distance)
    end)
  end
end
