defmodule D7Test do
  use ExUnit.Case
  import Y2021.D7

  test "calls p1" do
    input = "16,1,2,0,4,2,7,1,2,14"
    res = p1(input)
    assert res == 37
  end

  test "calls p2" do
    input = "16,1,2,0,4,2,7,1,2,14"

    res = p2(input)
    assert res == 168
  end

  test "minimum_fuel_position_crabby" do
    input = "16,1,2,0,4,2,7,1,2,14"

    crabs =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    {res, fuel} = minimum_fuel_position_crabby(crabs)
    assert res == 5
  end

  test "fuel_calculation_2" do
    input = "16,1,2,0,4,2,7,1,2,14"
    index = 5

    crabs =
      input
      |> String.trim()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    fuel_used =
      Enum.reduce(crabs, 0, fn crab, fuel ->
        distance = abs(crab - index)
        sum = Enum.sum(0..distance)
        fuel + sum
      end)
  end
end
