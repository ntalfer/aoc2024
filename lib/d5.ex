defmodule D5 do
  def p1(file) do
    {digraph, updates} = parse(file)

    updates
    |> Enum.filter(fn update -> right_order?(update, digraph) end)
    |> Enum.map(fn update -> Enum.at(update, div(Enum.count(update), 2)) end)
    |> Enum.sum()
  end

  defp parse(file) do
    [section1, section2] =
      file
      |> File.read!()
      |> String.split("\n\n")

    digraph = :digraph.new()

    section1
    |> String.split("\n")
    |> Enum.map(fn rule -> rule |> String.split("|") |> Enum.map(&String.to_integer/1) end)
    |> Enum.each(fn [n1, n2] ->
      :digraph.add_vertex(digraph, n1)
      :digraph.add_vertex(digraph, n2)
      :digraph.add_edge(digraph, n1, n2)
    end)

    updates =
      section2
      |> String.split(["\n"])
      |> Enum.map(fn u -> String.split(u, ",") |> Enum.map(&String.to_integer/1) end)

    {digraph, updates}
  end

  defp right_order?([n1, n2 | rest], digraph) do
    case :digraph.get_short_path(digraph, n1, n2) do
      [^n1, ^n2] ->
        right_order?([n2 | rest], digraph)

      _ ->
        false
    end
  end

  defp right_order?(_, _) do
    true
  end

  def p2(file) do
    {digraph, updates} = parse(file)

    updates
    |> Enum.filter(fn update -> not right_order?(update, digraph) end)
    |> Enum.map(fn update ->
      digraph
      |> :digraph_utils.subgraph(update)
      |> :digraph_utils.topsort()
    end)
    |> Enum.map(fn update -> Enum.at(update, div(Enum.count(update), 2)) end)
    |> Enum.sum()
  end
end
