defmodule D6 do
  def p1(file) do
    file
    |> parse()
    |> walk(MapSet.new([]))
    |> MapSet.to_list()
    |> Enum.map(fn {pos, _dir} -> pos end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp parse(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")

    height = Enum.count(lines)
    width = Enum.at(lines, 0) |> String.length()

    map =
      Enum.reduce(0..(height - 1), %{}, fn y, acc1 ->
        line = Enum.at(lines, y) |> to_charlist()

        Enum.reduce(0..(width - 1), acc1, fn x, acc2 ->
          Map.put(acc2, {x, y}, Enum.at(line, x))
        end)
      end)

    guard = Enum.find(map, fn {_, value} -> value == ?^ end)
    {map, height, width, guard}
  end

  defp walk({map, height, width, {pos, dir}}, visited) do
    if MapSet.member?(visited, {pos, dir}) do
      :loop
    else
      visited = MapSet.put(visited, {pos, dir})
      next_pos = next_pos(pos, dir)

      cond do
        out_of_map?(next_pos, width, height) ->
          visited

        Map.get(map, next_pos) == ?# ->
          walk({map, height, width, {pos, next_dir(dir)}}, visited)

        true ->
          walk({map, height, width, {next_pos, dir}}, visited)
      end
    end
  end

  defp next_pos({x, y}, ?>), do: {x + 1, y}
  defp next_pos({x, y}, ?<), do: {x - 1, y}
  defp next_pos({x, y}, ?^), do: {x, y - 1}
  defp next_pos({x, y}, ?v), do: {x, y + 1}

  defp out_of_map?({x, y}, width, height) do
    x < 0 or y < 0 or x >= width or y >= height
  end

  defp next_dir(?^), do: ?>
  defp next_dir(?>), do: ?v
  defp next_dir(?v), do: ?<
  defp next_dir(?<), do: ?^

  def p2(file) do
    {map, height, width, guard} = data = parse(file)
    # the candidates points are the points visited at p1
    # less the initial guard position
    candidates =
      data
      |> walk(MapSet.new([]))
      |> MapSet.to_list()
      |> Enum.map(fn {pos, _dir} -> pos end)
      |> Enum.uniq()
      |> Kernel.--([elem(guard, 0)])

    candidates
    |> Task.async_stream(fn candidate ->
      new_map = Map.put(map, candidate, ?#)

      case walk({new_map, height, width, guard}, MapSet.new([])) do
        :loop -> 1
        _ -> 0
      end
    end)
    |> Enum.reduce(0, fn {:ok, res}, acc -> acc + res end)
  end
end
