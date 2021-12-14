import AOC

aoc 2021, 13 do
  def to_num_coords(coord_string) do
    coord_string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def fold_vertical(mark_str, coords) do
    mark = String.to_integer(mark_str)

    Enum.map(coords, fn [x, y] ->
      if x > mark do
        [x - 2 * (x - mark), y]
      else
        [x, y]
      end
    end)
  end

  def fold_horizontal(mark_str, coords) do
    mark = String.to_integer(mark_str)

    Enum.map(coords, fn [x, y] ->
      if y > mark do
        [x, y - 2 * (y - mark)]
      else
        [x, y]
      end
    end)
  end

  def fold_coordinates([axis, mark], coords) when axis == "x", do: fold_vertical(mark, coords)
  def fold_coordinates([axis, mark], coords) when axis == "y", do: fold_horizontal(mark, coords)

  def p1(testInput \\ nil) do
    input = testInput || input_string()
    [coord_str, folds] = String.split(input, "\n\n")

    coords =
      coord_str
      |> String.split("\n", trim: true)
      |> Enum.map(&to_num_coords/1)

    prepared_folds =
      folds
      |> String.split("\n", trim: true)
      |> Enum.map(fn fold ->
        Regex.scan(~r/([xy])=(\d+)$/, fold)
        |> List.flatten()
        |> tl()
      end)

    fold_coordinates(hd(prepared_folds), coords)
    |> Enum.uniq()
    |> length()
  end

  def display(coords) do
    max_x = Enum.max_by(coords, &hd(&1))
    max_y = Enum.max_by(coords, &List.last(&1))
    [[x, _], [_, y]] = [max_x, max_y]
    IO.inspect({max_x, max_y})

    Enum.each(0..((x + 1) * (y + 1)), fn idx ->
      x_pos = Integer.mod(idx, x + 1)
      y_pos = div(idx, x + 1)

      if Enum.member?(coords, [x_pos, y_pos]) do
        IO.write("#")
      else
        IO.write(".")
      end

      if x_pos == x do
        IO.write("\n")
      end
    end)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()
    [coord_str, folds] = String.split(input, "\n\n")

    coords =
      coord_str
      |> String.split("\n", trim: true)
      |> Enum.map(&to_num_coords/1)

    prepared_folds =
      folds
      |> String.split("\n", trim: true)
      |> Enum.map(fn fold ->
        Regex.scan(~r/([xy])=(\d+)$/, fold)
        |> List.flatten()
        |> tl()
      end)

    Enum.reduce(prepared_folds, coords, fn fold, coord_plane ->
      fold_coordinates(fold, coord_plane)
    end)
    |> Enum.uniq()
    |> display()
  end
end
