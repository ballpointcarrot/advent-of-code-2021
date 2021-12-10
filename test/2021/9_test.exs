defmodule D9Test do
  use ExUnit.Case
  import Y2021.D9

  test "calls p1" do
    input = "2199943210\n3987894921\n9856789892\n8767896789\n9899965678"

    res = p1(input)
    assert res == 15
  end

  test "is_lowest_point" do
    heightmap_list = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    width = 3
    assert is_lowest_point(heightmap_list, width, {0, 1}) == true
    assert is_lowest_point(heightmap_list, width, {1, 2}) == false
  end

  test "calls p2" do
    input = "2199943210\n3987894921\n9856789892\n8767896789\n9899965678"

    res = p2(input)
    assert res == 1134
  end

  test "get_basin" do
    heightmap_list = [2, 1, 9, 3, 9, 8, 9, 8, 5]
    assert get_basin(heightmap_list, 3, {1, 1}) == [2, 3, 1]
  end
end
