defmodule D4 do
  def p1(file) do
    map = build_map(file)
    x_points = Map.filter(map, fn {_, v} -> v == ?X end) |> Map.keys()
    m_points = Map.filter(map, fn {_, v} -> v == ?M end) |> Map.keys()
    a_points = Map.filter(map, fn {_, v} -> v == ?A end) |> Map.keys()
    s_points = Map.filter(map, fn {_, v} -> v == ?S end) |> Map.keys()
    Process.put(:a_coords, [])

    Enum.reduce(-1..1, 0, fn delta_y, acc1 ->
      Enum.reduce(-1..1, acc1, fn delta_x, acc2 ->
        if delta_x == 0 and delta_y == 0 do
          acc2
        else
          acc2 +
            Enum.count(
              solve(~c"XMAS", {x_points, m_points, a_points, s_points}, delta_x, delta_y)
            )
        end
      end)
    end)
  end

  defp solve(~c"XMAS", {x_points, m_points, a_points, s_points}, delta_x, delta_y) do
    m_neighbors =
      Enum.reduce(x_points, [], fn {x, y}, acc ->
        neighbor = {x + delta_x, y + delta_y}

        if neighbor in m_points do
          [neighbor | acc]
        else
          acc
        end
      end)

    solve(~c"MAS", {m_neighbors, a_points, s_points}, delta_x, delta_y)
  end

  defp solve(~c"MAS", {m_points, a_points, s_points}, delta_x, delta_y) do
    a_neighbors =
      Enum.reduce(m_points, [], fn {x, y}, acc ->
        neighbor = {x + delta_x, y + delta_y}

        if neighbor in a_points do
          [neighbor | acc]
        else
          acc
        end
      end)

    solve(~c"AS", {a_neighbors, s_points}, delta_x, delta_y)
  end

  defp solve(~c"AS", {a_points, s_points}, delta_x, delta_y) do
    s_neighbors =
      Enum.reduce(a_points, [], fn {x, y}, acc ->
        neighbor = {x + delta_x, y + delta_y}

        if neighbor in s_points do
          Process.put(:a_coords, [{x, y} | Process.get(:a_coords)])
          [neighbor | acc]
        else
          acc
        end
      end)

    solve(~c"S", {s_neighbors}, delta_x, delta_y)
  end

  defp solve(~c"S", {s_points}, _, _) do
    s_points
  end

  def build_map(file) do
    lines = file |> File.read!() |> String.split("\n") |> Enum.map(&to_charlist/1)
    height = Enum.count(lines)
    width = Enum.at(lines, 0) |> Enum.count()

    Enum.reduce(0..(height - 1), %{}, fn y, map1 ->
      line = Enum.at(lines, y)

      Enum.reduce(0..(width - 1), map1, fn x, map2 ->
        value = Enum.at(line, x)
        Map.put(map2, {x, y}, value)
      end)
    end)
  end

  def p2(file) do
    map = build_map(file)
    m_points = Map.filter(map, fn {_, v} -> v == ?M end) |> Map.keys()
    a_points = Map.filter(map, fn {_, v} -> v == ?A end) |> Map.keys()
    s_points = Map.filter(map, fn {_, v} -> v == ?S end) |> Map.keys()
    Process.put(:a_coords, [])

    _ =
      for {delta_x, delta_y} <- [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}] do
        solve(~c"MAS", {m_points, a_points, s_points}, delta_x, delta_y)
      end

    Process.get(:a_coords)
    |> Enum.frequencies()
    |> Map.filter(fn {_, v} -> v == 2 end)
    |> Enum.count()
  end
end
