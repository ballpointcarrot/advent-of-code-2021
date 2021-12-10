import AOC

aoc 2021, 8 do
  digits = %{0 => 6, 1 => 2, 2 => 5, 3 => 5, 4 => 4, 5 => 5, 6 => 6, 7 => 3, 8 => 7, 9 => 6}

  def attach_digit(numbers) do
    Enum.map(numbers, fn num ->
      num_list =
        if is_bitstring(num) do
          String.graphemes(num)
        else
          num
        end

      option =
        case length(num_list) do
          2 -> 1
          4 -> 4
          3 -> 7
          7 -> 8
          6 -> [0, 6, 9]
          5 -> [2, 3, 5]
        end

      {num, option}
    end)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    lines =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(&tl(Enum.drop_while(&1, fn it -> it != "|" end)))
      |> Enum.map(&attach_digit/1)

    Enum.map(lines, fn output ->
      Enum.map(output, &elem(&1, 1))
      |> Enum.filter(&is_number/1)
    end)
    |> List.flatten()
    |> Enum.count()
  end

  def to_sorted_digit(digits) do
    digits
    |> Enum.map(&Enum.sort(&1))
  end

  def get_digits_and_output(split_line) do
    digits =
      Enum.take_while(split_line, &(&1 != "|"))
      |> Enum.map(&String.graphemes/1)

    output =
      tl(Enum.drop_while(split_line, &(&1 != "|")))
      |> Enum.map(&String.graphemes/1)

    {digits, output}
  end

  def determine_digits(signaled_digits) do
    one = Enum.find(signaled_digits, &(elem(&1, 1) == 1))
    four = Enum.find(signaled_digits, &(elem(&1, 1) == 4))
    seven = Enum.find(signaled_digits, &(elem(&1, 1) == 7))
    eight = Enum.find(signaled_digits, &(elem(&1, 1) == 8))
    zero_six_nine = Enum.filter(signaled_digits, &(elem(&1, 1) == [0, 6, 9]))
    two_three_five = Enum.filter(signaled_digits, &(elem(&1, 1) == [2, 3, 5]))

    [six] =
      Enum.reject(zero_six_nine, fn d ->
        Enum.all?(elem(one, 0), &Enum.member?(elem(d, 0), &1))
      end)

    [two, three, five] =
      Enum.sort_by(two_three_five, fn d ->
        cond do
          length(elem(seven, 0) -- elem(d, 0)) == 0 -> 3
          length(elem(six, 0) -- elem(d, 0)) == 1 -> 5
          true -> 2
        end
      end)

    [zero, nine] =
      zero_six_nine
      |> Enum.reject(&(&1 == six))
      |> Enum.sort_by(fn d ->
        if length(elem(three, 0) -- elem(d, 0)) == 1 do
          0
        else
          9
        end
      end)

    [zero, one, two, three, four, five, six, seven, eight, nine]
  end

  def find_from_digits(digits, entry) do
    digits
    |> Enum.with_index()
    |> Enum.find(fn {digit, _idx} ->
      elem(digit, 0) == entry
    end)
    |> elem(1)
    |> to_string()
  end

  def get_output(split_line) do
    {digits, output} = get_digits_and_output(split_line)
    sorted_digits = to_sorted_digit(digits)
    sorted_output = to_sorted_digit(output)

    digits = determine_digits(attach_digit(sorted_digits))

    sorted_output
    |> Enum.map(&find_from_digits(digits, &1))
    |> Enum.join()
    |> String.to_integer()
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    digits =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(&get_output/1)
      |> Enum.sum()
  end
end
