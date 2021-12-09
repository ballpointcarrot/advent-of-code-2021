import AOC

aoc 2021, 8 do
  digits = %{0 => 6, 1 => 2, 2 => 5, 3 => 5, 4 => 4, 5 => 5, 6 => 6, 7 => 3, 8 => 7, 9 => 6}

  def attach_digit(line) do
    numbers = tl(Enum.drop_while(line, fn it -> it != "|" end))

    Enum.map(numbers, fn num ->
      option =
        case length(String.to_charlist(num)) do
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
      |> Enum.map(&attach_digit/1)

    IO.inspect(lines)

    Enum.map(lines, fn output ->
      Enum.map(output, &elem(&1, 1))
      |> Enum.filter(&is_number/1)
    end)
    |> List.flatten()
    |> Enum.count()
  end

  def to_sorted_digit(line) do
    numbers =
      line
      |> Enum.map(&String.split(&1, " "))
      |> Enum.take_while(line, &(&1 != "|"))
      |> Enum.map(&Enum.sort(String.to_charlist(&1)))
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    lines =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&to_sorted_digit/1)
  end
end
