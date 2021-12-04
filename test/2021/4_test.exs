defmodule D4Test do
  use ExUnit.Case
  import Y2021.D4

  test "calls p1" do
    testInput = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0\n8  2 23  4 24\n21  9 14 16  7\n6 10  3 18  5\n1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5\n2  0 12  3  7
    """

    res = p1(testInput)
    IO.inspect(res)
  end

  test "board marking" do
    boards =
      build_boards(
        String.split(
          "\n22 13 17 11  0\n8  2 23  4 24\n21  9 14 16  7\n6 10  3 18  5\n1 12 20 15 19",
          "\n"
        )
      )

    updated_boards = mark_boards("22", boards)
    assert [] == updated_boards
  end

  test "check_for_win" do
    board = [
      {"3", true},
      {"15", false},
      {"0", false},
      {"2", false},
      {"22", false},
      {"9", true},
      {"18", false},
      {"13", false},
      {"17", false},
      {"5", false},
      {"19", true},
      {"8", false},
      {"7", false},
      {"25", false},
      {"23", false},
      {"20", true},
      {"11", false},
      {"10", false},
      {"24", false},
      {"4", false},
      {"14", true},
      {"21", false},
      {"16", false},
      {"12", false},
      {"6", false}
    ]

    {continue?, board} = check_for_win([board])
    assert continue? == :halt
  end

  test "calls p2" do
    testInput = """
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0\n8  2 23  4 24\n21  9 14 16  7\n6 10  3 18  5\n1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5\n2  0 12  3  7
    """

    res = p2(testInput)
    IO.inspect(res)
  end
end
