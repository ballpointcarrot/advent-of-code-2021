defmodule Y2021D13Test do
  use ExUnit.Case
  import Y2021.D13

  test "Calls p1" do
    input = """
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
    """

    assert p1(input) == 17
  end

  # test "calls p2" do
  # end
end
