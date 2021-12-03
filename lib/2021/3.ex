import AOC

aoc 2021, 3 do
  def gamma_rate([col1 | _rest], acc) when length(col1) == 0, do: acc

  def gamma_rate(columns, acc) do
    gamma_score =
      Enum.map(columns, &List.first/1)
      |> Enum.frequencies()

    gamma =
      Enum.max_by(gamma_score, fn tuple -> elem(tuple, 1) end)
      |> elem(0)

    columns_rest = Enum.map(columns, &tl/1)
    # while gamma_rate(columns_rest) != "" 
    # shove result onto 'gamma'
    gamma_rate(columns_rest, acc <> gamma)
  end

  def epsilon_rate([col1 | _rest], acc) when length(col1) == 0, do: acc

  def epsilon_rate(columns, acc) do
    epsilon_score =
      Enum.map(columns, &List.first/1)
      |> Enum.frequencies()

    epsilon =
      Enum.min_by(epsilon_score, fn tuple -> elem(tuple, 1) end)
      |> elem(0)

    columns_rest = Enum.map(columns, &tl/1)
    # while epsilon_rate(columns_rest) != "" 
    # shove result onto 'epsilon'
    epsilon_rate(columns_rest, acc <> epsilon)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    # Step 1 - read in all numbers
    # Step 2 - grab each column
    # Step 3 - calculate gamma rate (most common)
    # Step 4 - calculate epsilon rate (least common)
    # Step 5 - gamma * epsilon
    columns =
      input
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    gamma = gamma_rate(columns, "")
    epsilon = epsilon_rate(columns, "")

    String.to_integer(gamma, 2) * String.to_integer(epsilon, 2)
  end

  def oxygen_rate(bin_strings, _index) when length(bin_strings) == 1, do: List.first(bin_strings)

  def oxygen_rate(bin_strings, index \\ 0) do
    o2_score =
      bin_strings
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.at(&1, index))
      |> Enum.frequencies()

    o2_indicator =
      if(o2_score["0"] == o2_score["1"]) do
        "1"
      else
        Enum.max_by(o2_score, fn tuple -> elem(tuple, 1) end)
        |> elem(0)
      end

    oxygen_rate(
      Enum.filter(bin_strings, fn bs -> String.at(bs, index) == o2_indicator end),
      index + 1
    )
  end

  def carbon_dioxide_rate(bin_strings, _index) when length(bin_strings) == 1,
    do: List.first(bin_strings)

  def carbon_dioxide_rate(bin_strings, index \\ 0) do
    co2_score =
      bin_strings
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.at(&1, index))
      |> Enum.frequencies()

    co2_indicator =
      if(co2_score["0"] == co2_score["1"]) do
        "0"
      else
        Enum.min_by(co2_score, fn tuple -> elem(tuple, 1) end)
        |> elem(0)
      end

    carbon_dioxide_rate(
      Enum.filter(bin_strings, fn bs -> String.at(bs, index) == co2_indicator end),
      index + 1
    )
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()

    # Step 1 - read in all numbers
    # Step 2 - grab each column
    # Step 3 - calculate oxygen rate (most common)
    # Step 4 - calculate CO2 rate (least common)
    # Step 5 - oxygen * CO2
    columns =
      input
      |> String.trim()
      |> String.split("\n")

    o2 = oxygen_rate(columns)
    co2 = carbon_dioxide_rate(columns)

    String.to_integer(o2, 2) * String.to_integer(co2, 2)
  end
end
