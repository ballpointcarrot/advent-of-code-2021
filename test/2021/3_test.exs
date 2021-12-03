defmodule D3Test do
  use ExUnit.Case
  import Y2021.D3

  test "calls p1" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    res = p1(input)
    assert res == 198
  end

  test "result from oxygen_rate" do
    input = """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """

    input_list =
      input
      |> String.trim()
      |> String.split("\n")

    assert oxygen_rate(input_list) == "10111"
  end

  test "calls p2" do
    input = """
    """

    IO.inspect(p2(input))
  end
end
