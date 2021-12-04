import AOC

aoc 2021, 4 do
  def construct_board(line, board) do
    board_line =
      line
      |> String.trim()
      |> String.split(~r/\s+/)
      |> Enum.map(&{&1, false})

    if length(board) == 0 do
      board_line
    else
      board ++ board_line
    end
  end

  def build_boards(board_lines) do
    Enum.reduce(board_lines, [], fn line, boards ->
      if String.length(line) == 0 do
        [[] | boards]
      else
        List.update_at(boards, 0, &construct_board(line, &1))
      end
    end)
  end

  def horizontal_win(board) do
    rows =
      Enum.chunk_every(0..24, 5)
      |> Enum.map(fn row ->
        Enum.map(row, fn entry ->
          tuple = Enum.at(board, entry)
          elem(tuple, 1)
        end)
        |> Enum.reduce(fn next, acc ->
          next and acc
        end)
      end)

    if Enum.any?(rows) do
      board
    else
      nil
    end
  end

  def vertical_win(board) do
    columns = Enum.map(0..4, &Enum.map(0..4, fn x -> x * 5 + &1 end))

    columns_realized =
      columns
      |> Enum.map(fn column ->
        Enum.map(column, fn entry ->
          tuple = Enum.at(board, entry)
          elem(tuple, 1)
        end)
        |> Enum.reduce(fn next, acc ->
          next and acc
        end)
      end)

    if Enum.any?(columns_realized) do
      board
    else
      nil
    end
  end

  def check_for_win(boards) when length(boards) == 0, do: {:halt, []}

  def check_for_win(mark, boards) do
    winning_board = Enum.find(boards, &horizontal_win/1) || Enum.find(boards, &vertical_win/1)

    if winning_board do
      {:halt, {mark, winning_board}}
    else
      {:cont, {mark, boards}}
    end
  end

  def mark_boards(to_mark, {_last, boards}) do
    updated_boards =
      Enum.map(boards, fn board ->
        idx = Enum.find_index(board, fn item -> elem(item, 0) == to_mark end)

        unless is_nil(idx) do
          List.replace_at(board, idx, {to_mark, true})
        else
          board
        end
      end)

    check_for_win(to_mark, updated_boards)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    [bingo_numbers | rest] =
      input
      |> String.trim()
      |> String.split("\n")

    bingo_numbers_list = String.split(bingo_numbers, ",")

    boards = build_boards(rest)

    {last_number, winning_board} =
      Enum.reduce_while(bingo_numbers_list, {nil, boards}, &mark_boards/2)

    IO.inspect(winning_board)

    unmarked_board_sum =
      winning_board
      |> Enum.filter(fn tuple -> elem(tuple, 1) == false end)
      |> Enum.map(fn tuple -> String.to_integer(elem(tuple, 0)) end)
      |> Enum.sum()

    String.to_integer(last_number) * unmarked_board_sum
  end

  def remove_winnable_board(mark, boards) do
    leftover_boards =
      Enum.filter(boards, fn board ->
        !(horizontal_win(board) || vertical_win(board))
      end)

    if length(leftover_boards) == 0 do
      {:halt, {mark, List.first(boards)}}
    else
      {:cont, {mark, leftover_boards}}
    end
  end

  def narrow_boards(to_mark, {_last, boards}) do
    updated_boards =
      Enum.map(boards, fn board ->
        idx = Enum.find_index(board, fn item -> elem(item, 0) == to_mark end)

        unless is_nil(idx) do
          List.replace_at(board, idx, {to_mark, true})
        else
          board
        end
      end)

    remove_winnable_board(to_mark, updated_boards)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    [bingo_numbers | rest] =
      input
      |> String.trim()
      |> String.split("\n")

    bingo_numbers_list = String.split(bingo_numbers, ",")

    boards = build_boards(rest)

    {last_number, losing_board} =
      Enum.reduce_while(bingo_numbers_list, {nil, boards}, &narrow_boards/2)

    unmarked_board_sum =
      losing_board
      |> Enum.filter(fn tuple -> elem(tuple, 1) == false end)
      |> Enum.map(fn tuple -> String.to_integer(elem(tuple, 0)) end)
      |> Enum.sum()

    String.to_integer(last_number) * unmarked_board_sum
  end
end
