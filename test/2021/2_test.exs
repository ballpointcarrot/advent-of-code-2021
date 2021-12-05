defmodule D2Test do
  use ExUnit.Case
  import Y2021.D2

  test "calls p1" do
    input = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """

    res = p1(input)
    assert res == 150
    # IO.inspect(p1(input))
  end

  test "calls p2" do
    input = """
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
    """

    res = p2(input)
    assert res == 900
    # IO.inspect(p2(input))
  end
end
