import AOC

aoc 2021, 10 do
  def is_corrupted(line_chars, prev) when length(line_chars) == 0, do: {:incomplete, prev}

  def is_corrupted(line_chars, prev \\ []) do
    braces = %{"{" => "}", "[" => "]", "(" => ")", "<" => ">"}
    [curr | rest] = line_chars

    cond do
      Enum.member?(Map.keys(braces), curr) ->
        is_corrupted(rest, [curr | prev])

      Enum.member?(Map.values(braces), curr) and
          braces[hd(prev)] == curr ->
        is_corrupted(rest, tl(prev))

      true ->
        {:corrupted, curr}
    end
  end

  def get_corruption_score(line_chars, prev \\ []) do
    braces = %{"{" => "}", "[" => "]", "(" => ")", "<" => ">"}

    score_map = %{
      ")" => 3,
      "]" => 57,
      "}" => 1197,
      ">" => 25137
    }

    [curr | rest] = line_chars

    cond do
      Enum.member?(Map.keys(braces), curr) ->
        get_corruption_score(rest, [curr | prev])

      Enum.member?(Map.values(braces), curr) and
          braces[hd(prev)] == curr ->
        get_corruption_score(rest, tl(prev))

      true ->
        score_map[curr]
    end
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    corrupt_lines =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.filter(&(elem(is_corrupted(&1), 0) == :corrupted))

    corrupt_lines
    |> Enum.map(&get_corruption_score/1)
    |> Enum.frequencies()
    |> Enum.map(fn {k, v} ->
      k * v
    end)
    |> Enum.sum()
  end

  def get_incomplete_score(opened_stack, score) when length(opened_stack) == 0, do: score

  def get_incomplete_score(opened_stack, score \\ 0) do
    score_map = %{
      "(" => 1,
      "[" => 2,
      "{" => 3,
      "<" => 4
    }

    [head | tail] = opened_stack

    get_incomplete_score(tail, score * 5 + score_map[head])
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    incomplete_lines =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
      |> Enum.filter(&(elem(is_corrupted(&1), 0) == :incomplete))

    incomplete_scores =
      incomplete_lines
      |> Enum.map(&is_corrupted/1)
      |> Enum.map(fn {_, incomplete_stack} ->
        get_incomplete_score(incomplete_stack)
      end)
      |> Enum.sort()
      |> Enum.with_index()

    incomplete_scores
    |> Enum.drop_while(fn {_, idx} -> idx + 1 < length(incomplete_scores) / 2 end)
    |> hd()
    |> elem(0)
  end
end
