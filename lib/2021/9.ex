import AOC

aoc 2021, 9 do
  def to_nums(str) do
    str
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  def cardinal_directions(heightmap_list, width, {idx, elem}) do
    left =
      if Integer.mod(idx, width) == 0 do
        nil
      else
        {idx - 1, Enum.at(heightmap_list, idx - 1)}
      end

    right =
      if Integer.mod(idx, width) == width - 1 do
        nil
      else
        {idx + 1, Enum.at(heightmap_list, idx + 1)}
      end

    up =
      if idx - width < 0 do
        nil
      else
        {idx - width, Enum.at(heightmap_list, idx - width)}
      end

    down =
      if idx + width > length(heightmap_list) do
        nil
      else
        {idx + width, Enum.at(heightmap_list, idx + width)}
      end

    [left, right, up, down]
  end

  def is_lowest_point(heightmap_list, width, {idx, el}) do
    lowest_direction =
      cardinal_directions(heightmap_list, width, {idx, el})
      |> Enum.reject(&is_nil/1)
      |> Enum.min_by(&elem(&1, 1))

    el < elem(lowest_direction, 1)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    heightmap =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&to_nums/1)

    width = length(hd(heightmap))

    heightmap_list =
      heightmap
      |> List.flatten()

    low_points =
      heightmap_list
      |> Enum.with_index(fn elem, idx -> {idx, elem} end)
      |> Enum.map(&{elem(&1, 1), is_lowest_point(heightmap_list, width, &1)})
      |> Enum.filter(&elem(&1, 1))

    low_points
    |> Enum.map(&(elem(&1, 0) + 1))
    |> Enum.sum()
  end

  def get_basin(heightmap_list, width, current, used \\ []) do
    {_, elem} = current

    cardinal_directions(heightmap_list, width, current)
    |> Enum.reduce([elem], fn direction, basin ->
      cond do
        is_nil(direction) -> basin
        elem(direction, 1) == 9 -> basin
        Enum.member?(used, direction) -> basin
        true -> [get_basin(heightmap_list, width, direction, [current | used]) | basin]
      end
    end)
    |> List.flatten()
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    heightmap =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&to_nums/1)

    width = length(hd(heightmap))

    heightmap_list =
      heightmap
      |> List.flatten()

    low_points =
      heightmap_list
      |> Enum.with_index(fn elem, idx -> {idx, elem} end)
      |> Enum.map(&{elem(&1, 1), is_lowest_point(heightmap_list, width, &1)})
      |> Enum.filter(&elem(&1, 1))
      |> Enum.map(&get_basin(heightmap_list, width, &1))
  end
end
