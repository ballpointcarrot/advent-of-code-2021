import AOC

aoc 2021, 11 do
  def step(grid, width) do
    next_step = Enum.map(grid, &(&1 + 1))
    flash(next_step, width)
  end

  def blast_radius(index, width, max) do
    List.flatten([
      Enum.to_list((index - width - 1)..(index - width + 1)),
      Enum.to_list((index - 1)..(index + 1)),
      Enum.to_list((index + width - 1)..(index + width + 1))
    ])
    |> Enum.uniq()
    |> Enum.reject(fn num -> num < 0 or num >= max end)
  end

  def flash(grid, width) do
    if Enum.all?(grid, &(&1 < 9)) do
      grid
    else
      first_nine = Enum.find_index(grid, fn it -> it >= 9 end)
    end
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    width =
      input
      |> String.trim()
      |> String.split("\n")
      |> hd()
      |> length()

    grid =
      input
      |> String.replace(~r/\s+/, "")
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
  end

  def p2 do
  end
end
