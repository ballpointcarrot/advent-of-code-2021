defmodule Y2021D14Test do
  use ExUnit.Case
  import Y2021.D14

  test "apply_rules" do
    assert apply_rules("NNCB", [["NN", "C"]]) == "NCNCB"
    assert apply_rules("NNCB", [["CH", "B"], ["CB", "H"], ["NN", "C"]]) == "NCNCHB"
  end

  test "Calls p1" do
    input = """
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
    """

    assert p1(input) == 1588
  end

  # test "calls p2" do
  # end
end
