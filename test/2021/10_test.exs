defmodule D10Test do
  use ExUnit.Case
  import Y2021.D10

  test "is_corrupted" do
    assert is_corrupted(String.graphemes("<>")) == :incomplete
    assert is_corrupted(String.graphemes("<(())]")) == :corrupted
    assert is_corrupted(String.graphemes("[<>({}){}[([])<>]]")) == :incomplete
  end

  test "get_corruption_score" do
    assert get_corruption_score(String.graphemes("<(())]")) == 57
    assert get_corruption_score(String.graphemes("<(()))")) == 3
    assert get_corruption_score(String.graphemes("<(())}")) == 1197
    assert get_corruption_score(String.graphemes("{(())>")) == 25137
  end

  test "calls p1" do
    input = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """

    assert p1(input) == 26397
  end

  test "calls p2" do
    input = """
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
    """

    assert p2(input) == 288_957
  end
end
