defmodule D8 do
  def p1(file) do
    {groups, height, width} = build_map(file)

    groups
    |> Enum.map(&antinodes/1)
    |> List.flatten()
    |> Enum.filter(fn {x, y} -> x >= 0 and x < width and y >= 0 and y < height end)
    |> Enum.uniq()
    |> Enum.count()
  end

  defp antinodes(group) do
    for pos1 <- group, pos2 <- group, pos1 != pos2, into: [] do
      [{xa, ya}, {xb, yb}] = List.keysort([pos1, pos2], 1)
      dx = xb - xa
      dy = ya - yb
      [{xa - dx, ya + dy}, {xb + dx, yb - dy}]
    end
  end

  def build_map(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&to_charlist/1)

    height = Enum.count(lines)
    width = Enum.at(lines, 0) |> length()

    map =
      for x <- 0..(width - 1), y <- 0..(height - 1), into: %MapSet{} do
        value =
          lines
          |> Enum.at(y)
          |> Enum.at(x)

        {{x, y}, value}
      end

    groups =
      map
      |> MapSet.filter(fn {_, val} -> val != ?. end)
      |> Enum.group_by(fn {_, val} -> val end)
      |> Enum.reduce([], fn {_, list}, acc ->
        if length(list) == 1, do: acc, else: [list |> Enum.map(fn {pos, _} -> pos end) | acc]
      end)

    {groups, height, width}
  end
end
