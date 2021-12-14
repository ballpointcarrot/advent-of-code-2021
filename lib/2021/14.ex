import AOC

aoc 2021, 14 do
  def apply_rules(source, rules) do
    rules_to_apply =
      Enum.filter(rules, fn [search_key, _] ->
        {:ok, re} = Regex.compile(search_key)
        String.match?(source, re)
      end)

    rules_to_apply =
      rules_to_apply
      |> Enum.map(fn [search_key, inserted] ->
        search_list = String.graphemes(search_key)
        replacement = Enum.intersperse(search_list, inserted)
        {search_list, replacement}
      end)

    source
    |> String.graphemes()
    |> Enum.chunk_every(2, 1)
    |> Enum.map(fn pair ->
      found_pair =
        Enum.find(rules_to_apply, fn {search_list, _} ->
          search_list == pair
        end)

      if is_nil(found_pair) do
        pair
      else
        elem(found_pair, 1)
      end
    end)
    |> Enum.reduce("", fn pair, str ->
      append =
        if length(pair) == 3 do
          List.to_string(Enum.take(pair, 2))
        else
          hd(pair)
        end

      str <> append
    end)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    [template, rules] = String.split(input, "\n\n", trim: true)

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, " -> "))

    polymer = Enum.take(Stream.drop(Stream.iterate(template, &apply_rules(&1, rules)), 10), 1)

    freq =
      polymer
      |> hd()
      |> String.graphemes()
      |> Enum.frequencies()
      |> Enum.sort_by(fn {_, v} -> v end)

    least = hd(freq)
    most = hd(Enum.reverse(freq))
    elem(most, 1) - elem(least, 1)
  end
end
