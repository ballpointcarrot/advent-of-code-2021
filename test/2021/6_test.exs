defmodule D6Test do
  use ExUnit.Case
  import Y2021.D6

  test "calls p1" do
    input = "3,4,3,1,2"
    res = p1(input)
    assert res == 5934
  end

  test "next_generation" do
    assert next_generation([5]) == [4]
    assert next_generation([0]) == [6, 8]
    assert next_generation([0, 1]) == [6, 0, 8]
  end

  test "calls p2" do
    input = "3,4,3,1,2"
    res = p2(input)
    assert res == 26_984_457_539
  end
end
