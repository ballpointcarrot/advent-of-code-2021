defmodule Y2021D12Test do
  use ExUnit.Case
  import Y2021.D12

  test "generate_graph" do
    input = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    assert generate_graph(input) == %{
             "start" => ["A", "b"],
             "A" => ["c", "b", "end", "start"],
             "b" => ["d", "A", "end", "start"],
             "c" => ["A"],
             "d" => ["b"],
             "end" => ["A", "b"]
           }
  end

  test "walk_graph" do
    assert walk_graph(%{
             "start" => ["A", "b"],
             "A" => ["c", "b", "end", "start"],
             "b" => ["d", "A", "end", "start"],
             "c" => ["A"],
             "d" => ["b"],
             "end" => ["A", "b"]
           }) == [
             ["end", "A", "b", "A", "c", "A", "start"],
             ["end", "b", "A", "c", "A", "start"],
             ["end", "A", "c", "A", "start"],
             ["end", "A", "c", "A", "b", "A", "start"],
             ["end", "A", "b", "A", "start"],
             ["end", "b", "A", "start"],
             ["end", "A", "start"],
             ["end", "A", "c", "A", "b", "start"],
             ["end", "A", "b", "start"],
             ["end", "b", "start"]
           ]
  end

  test "calls p1" do
    input = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    assert p1(input) == 10

    input = """
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
    """

    assert p1(input) == 19

    input = """
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
    """

    assert p1(input) == 226
  end

  test "calls p2" do
    input = """
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
    """

    assert p2(input) == 36
  end
end
