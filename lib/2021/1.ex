import AOC

aoc 2021, 1 do
  defp count_up(next, [nil, _]), do: [next, 0]
  defp count_up(next, [prev, num_inc]) when next > prev, do: [next, num_inc+1]
  defp count_up(next, [_prev, num_inc]), do: [next, num_inc]

  def p1(testInput \\ nil) do
    input = testInput || input_string()
    numbers =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)

    Enum.reduce(numbers, [nil, nil], &count_up/2)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()
    numbers = 
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(3,1,:discard)
      |> Enum.map(&Enum.sum/1)

    Enum.reduce(numbers, [nil, nil], &count_up/2)
  end
end
