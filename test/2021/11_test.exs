defmodule Y2021D11Test do
  use ExUnit.Case
  import Y2021.D11

  def to_num(str) do
    str
    |> String.replace(~r/\s+/, "")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end

  test "step" do
    assert step([1, 2, 2, 3], 2) == [2, 3, 3, 4]

    input = """
    11111
    19991
    19191
    19991
    11111
    """

    expected_output = """
    34543
    40004
    50005
    40004
    34543
    """

    [numbers, out] = Enum.map([input, expected_output], &to_num(&1))
    assert step(numbers, 5) == out
  end

  test "calls p1" do
    input = """
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
    """

    assert p1(input) == 1656
  end
end
