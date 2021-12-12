import AOC

aoc 2021, 12 do
  def generate_graph(input) do
    steps =
      input
      |> String.trim()
      |> String.replace(~r/[\s]+/, ",")
      |> String.split(",")
      |> Enum.map(&String.split(&1, "-"))

    Enum.map(steps, fn [src, dest] ->
      {src, dest}
    end)
    |> Enum.reduce(%{}, fn {src, dest}, map ->
      updated_map =
        if is_nil(map[src]) do
          Map.put(map, src, [dest])
        else
          Map.update!(map, src, fn existing ->
            Enum.uniq([dest | existing])
          end)
        end

      if is_nil(updated_map[dest]) do
        Map.put(updated_map, dest, [src])
      else
        Map.update!(updated_map, dest, fn existing ->
          Enum.uniq([src | existing])
        end)
      end
    end)
  end

  def walk_graph(_graph, current_node, current_path)
      when current_node == "end",
      do: [current_path]

  def walk_graph(graph, current_node \\ "start", current_path \\ ["start"]) do
    start_points = graph[current_node]

    Enum.flat_map(start_points, fn next ->
      flag =
        if Enum.member?(current_path, next) do
          # If it's already downcase
          if next == String.downcase(next) do
            :halt
          end
        else
          :cont
        end

      if flag == :halt do
        []
      else
        walk_graph(graph, next, [next | current_path])
      end
    end)
  end

  def p1(testInput \\ nil) do
    input = testInput || input_string()

    graph = generate_graph(input)

    options = walk_graph(graph)
    length(options)
  end

  def walk_graph_with_revisit(_graph, current_node, current_path)
      when current_node == "end",
      do: [current_path]

  def walk_graph_with_revisit(graph, current_node \\ "start", current_path \\ [{"start", 1}]) do
    start_points = graph[current_node]

    Enum.flat_map(start_points, fn next ->
      entry =
        Enum.find(current_path, fn e ->
          elem(e, 0) == next
        end)

      unless is_nil(entry) do
        # If it's already downcase
        if next == String.downcase(next) do
          cond do
            next == "start" -> []
            Enum.any?(current_path, fn e -> elem(e, 1) == 2 end) -> []
            true -> walk_graph_with_revisit(graph, next, [{next, 2} | current_path])
          end
        else
          walk_graph_with_revisit(graph, next, [{next, 1} | current_path])
        end
      else
        walk_graph_with_revisit(graph, next, [{next, 1} | current_path])
      end
    end)
  end

  def p2(testInput \\ nil) do
    input = testInput || input_string()
    graph = generate_graph(input)

    options = walk_graph_with_revisit(graph)
    length(options)
  end
end
