import AOC

aoc 2021, 5 do
  def line_into_coords(line_segment) do
    String.split(line_segment, " -> ", trim: true)
    |> Enum.map(fn coord ->
      coord
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def is_horizontal_or_vertical(line_segment) do
    [coord_1, coord_2] = line_into_coords(line_segment)
    [x1, y1] = coord_1
    [x2, y2] = coord_2
    x1 == x2 || y1 == y2
  end

  def into_path_points(coord) do
    [[x1, y1], [x2, y2]] = coord

    cond do
      x1 == x2 ->
        Enum.map(y1..y2, &[x1, &1])

      y1 == y2 ->
        Enum.map(x1..x2, &[&1, y1])

      true ->
        build_diagonal(coord)
    end
  end

  def build_diagonal([[x1, y1], [x2, y2]]) do
    Enum.zip([x1..x2, y1..y2])
    |> Enum.map(&Tuple.to_list/1)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.filter(&is_horizontal_or_vertical/1)
      |> Enum.map(&line_into_coords/1)
      |> Enum.map(&into_path_points/1)
      |> Enum.concat()
      |> Enum.frequencies()
      |> Enum.filter(fn thing -> elem(thing, 1) >= 2 end)

    length(result)
  end

  def is_diagonal(line_segment) do
    [[x1, y1], [x2, y2]] = line_into_coords(line_segment)
    abs(x1 - x2) == abs(y1 - y2)
  end

  def is_horizontal_vertical_or_diagonal(line_segment) do
    is_diagonal(line_segment) or is_horizontal_or_vertical(line_segment)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    result =
      input
      |> String.split("\n", trim: true)
      |> Enum.filter(&is_horizontal_vertical_or_diagonal/1)
      |> Enum.map(&line_into_coords/1)
      |> Enum.map(&into_path_points/1)
      |> Enum.concat()
      |> Enum.frequencies()
      |> Enum.filter(fn thing -> elem(thing, 1) >= 2 end)

    length(result)
  end
end
