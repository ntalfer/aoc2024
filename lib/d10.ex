defmodule D10 do
  def p1(file) do
    file
    |> build_map()
    |> trails(0)
  end

  defp trails({map, _height, _width}, trailhead_value) do
    trailheads = Enum.filter(map, fn {_, value} -> value == trailhead_value end)

    trailheads
    |> Enum.map(fn trailhead ->
      reachable_nines(trailhead, map, MapSet.new()) |> MapSet.size()
    end)
    |> Enum.sum()
  end

  def reachable_nines({pos, 9}, _, nines) do
    MapSet.put(nines, pos)
  end

  def reachable_nines({{x, y}, value}, map, nines) do
    neighbors = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]

    neighbors
    |> Enum.reduce(nines, fn neighbor, acc ->
      case MapSet.member?(map, {neighbor, value + 1}) do
        true ->
          reachable_nines({neighbor, value + 1}, map, acc)

        _ ->
          acc
      end
    end)
  end

  def build_map(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn line ->
        line |> String.split("", trim: true) |> Enum.map(&String.to_integer/1)
      end)

    height = Enum.count(lines)
    width = Enum.at(lines, 0) |> length()

    map =
      for x <- 0..(width - 1), y <- 0..(height - 1), into: MapSet.new() do
        value =
          lines
          |> Enum.at(y)
          |> Enum.at(x)

        {{x, y}, value}
      end

    {map, height, width}
  end

  def p2(file) do
    file
    |> build_map()
    |> trails_p2(0)
  end

  defp trails_p2({map, _height, _width}, trailhead_value) do
    trailheads = Enum.filter(map, fn {_, value} -> value == trailhead_value end)

    trailheads
    |> Enum.map(fn trailhead ->
      reachable_nines_p2(trailhead, map)
    end)
    |> Enum.sum()
  end

  def reachable_nines_p2({_, 9}, _) do
    1
  end

  def reachable_nines_p2({{x, y}, value}, map) do
    neighbors = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]

    neighbors
    |> Enum.reduce(0, fn neighbor, acc ->
      case MapSet.member?(map, {neighbor, value + 1}) do
        true ->
          acc + reachable_nines_p2({neighbor, value + 1}, map)

        _ ->
          acc
      end
    end)
  end
end
