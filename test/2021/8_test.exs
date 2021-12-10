defmodule D8Test do
  use ExUnit.Case
  import Y2021.D8

  test "attach_digit" do
    numbers = ["d2", "323e"]
    assert attach_digit(numbers) == [{"d2", 1}, {"323e", 4}]
  end

  test "calls p1" do
    input = """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """

    res = p1(input)
    assert res == 26
  end

  test "to_sorted_digit" do
    assert to_sorted_digit(
             "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
             |> String.split(" ")
             |> get_digits_and_output()
             |> elem(0)
           ) == [
             ["b", "e"],
             ["a", "b", "c", "d", "e", "f", "g"],
             ["b", "c", "d", "e", "f", "g"],
             ["a", "c", "d", "e", "f", "g"],
             ["b", "c", "e", "g"],
             ["c", "d", "e", "f", "g"],
             ["a", "b", "d", "e", "f", "g"],
             ["b", "c", "d", "e", "f"],
             ["a", "b", "c", "d", "f"],
             ["b", "d", "e"]
           ]
  end

  test "determine_digits" do
    input =
      "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe"
      |> String.split(" ")

    {digits, output} = get_digits_and_output(input)
    sorted_digits = to_sorted_digit(digits)

    assert determine_digits(attach_digit(sorted_digits)) ==
             [
               {["a", "b", "d", "e", "f", "g"], [0, 6, 9]},
               {["b", "e"], 1},
               {["a", "b", "c", "d", "f"], [2, 3, 5]},
               {["b", "c", "d", "e", "f"], [2, 3, 5]},
               {["b", "c", "e", "g"], 4},
               {["c", "d", "e", "f", "g"], [2, 3, 5]},
               {["a", "c", "d", "e", "f", "g"], [0, 6, 9]},
               {["b", "d", "e"], 7},
               {["a", "b", "c", "d", "e", "f", "g"], 8},
               {["b", "c", "d", "e", "f", "g"], [0, 6, 9]}
             ]
  end

  test "Calls p2" do
    input = """
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
    """

    assert p2(input) == 61229
  end
end
