import AOC

aoc 2021, 6 do
  def next_generation(fish) do
    next_fish =
      Enum.map(fish, fn f ->
        case f do
          0 -> 6
          _ -> f - 1
        end
      end)

    number_of_new_fish = Enum.count(fish, &(&1 == 0))
    # thanks, StackOverflow: https://stackoverflow.com/a/41351683
    next_fish ++ List.duplicate(8, number_of_new_fish)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    fish =
      input
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    Stream.iterate(fish, &next_generation/1)
    |> Enum.take(81)
    |> List.last()
    |> length()
  end

  def next_generation_count_map(fish_count_map) do
    next_day =
      Enum.map(fish_count_map, fn {gen, count} ->
        {gen - 1, count}
      end)
      |> Map.new()

    next_day
    |> Map.update(6, Map.get(next_day, -1), fn existing_value ->
      addend = (is_nil(existing_value) && 0) || existing_value
      addend + (Map.get(next_day, -1, 0) || 0)
    end)
    |> Map.update(8, Map.get(next_day, -1), fn existing_value ->
      addend = (is_nil(existing_value) && 0) || existing_value
      addend + (Map.get(next_day, -1, 0) || 0)
    end)
    |> Map.delete(-1)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    fish_count_map =
      input
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.frequencies()

    counts =
      Stream.iterate(fish_count_map, &next_generation_count_map/1)
      |> Enum.take(257)
      |> List.last()
      |> Enum.map(fn {_, ct} -> ct end)
      |> Enum.sum()

    counts
  end
end
