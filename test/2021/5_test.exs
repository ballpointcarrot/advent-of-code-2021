defmodule D5Test do
  use ExUnit.Case
  import Y2021.D5

  test "calls p1" do
    input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    res = p1(input)
    assert res = 5
  end

  test "build_diagonal" do
    assert build_diagonal([[1, 1], [3, 3]]) == [[1, 1], [2, 2], [3, 3]]
  end

  test "is_diagonal" do
    assert is_diagonal("1,1 -> 3,3") == true
    assert is_diagonal("4,0 -> 7,3") == true
    assert is_diagonal("1,1 -> 3,3") == true
    assert is_diagonal("1,1 -> 3,3") == true
    # x1, y1 -> x2, y2 is Diagonal if x1-x2 == y1-y2
    assert is_diagonal("9,7 -> 7,9") == true

    assert is_diagonal("1,1 -> 1,4") == false
  end

  test "is_horizontal_or_vertical" do
    assert is_horizontal_or_vertical("0,9 -> 5,9") == true
    assert is_horizontal_or_vertical("8,0 -> 0,8") == false
  end

  test "into_path_points" do
    input = [[0, 9], [5, 9]]
    assert into_path_points(input) == [[0, 9], [1, 9], [2, 9], [3, 9], [4, 9], [5, 9]]
  end

  test "calls p2" do
    input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    res = p2(input)
    assert res = 12
  end
end
