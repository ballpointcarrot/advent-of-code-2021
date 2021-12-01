defmodule D1Test do
  use ExUnit.Case
  import Y2021.D1

  test "correctly handles example" do
    input = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """

    [_, res] = star1(input)
    assert res == 7

    input2 = """
    1
    2
    3
    2
    """

    [_, res2] = star1(input2)
    assert res2 == 2

    input3 = """
    130
    142
    148
    147
    157
    160
    162
    160
    165
    164
    171
    169
    160
    165
    """

    [_, res3] = star1(input3)
    assert res3 == 8
  end

  # test "calls p1" do
  #   IO.inspect(p1())
  # end

  test "satisfies example for star 2" do
    input = """
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
    """

    [_, res] = p2(input)
    assert res == 5
  end
end
