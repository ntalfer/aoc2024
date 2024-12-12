defmodule D12 do
  def p1(file) do
    {_pos2region, region2pos} = build_maps(file)

    region2pos
    |> Enum.map(&get_area_and_perimeter/1)
    |> Enum.map(fn {a, p} -> a * p end)
    |> Enum.sum()
  end

  defp get_area_and_perimeter({_region, points}) do
    {area(points), perimeter(points)}
  end

  defp area(points), do: MapSet.size(points)

  defp perimeter(points) do
    Enum.reduce(points, 0, fn {x, y}, acc ->
      neighbors = [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]

      neighbors
      |> Enum.reduce(acc, fn neighbor, acc1 ->
        if MapSet.member?(points, neighbor) do
          acc1
        else
          acc1 + 1
        end
      end)
    end)
  end

  defp build_maps(file) do
    lines =
      file
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(fn line -> String.split(line, "", trim: true) end)

    height = Enum.count(lines)
    width = Enum.at(lines, 0) |> Enum.count()

    map =
      for x <- 0..(width - 1), y <- 0..(height - 1), into: %{} do
        pos = {x, y}
        value = Enum.at(lines, y) |> Enum.at(x)
        {pos, value}
      end

    {pos2region, region2pos} =
      Enum.reduce(0..(height - 1), {%{}, %{}}, fn y, acc1 ->
        Enum.reduce(0..(width - 1), acc1, fn x, {p2r, r2p} ->
          pos = {x, y}
          value = Map.get(map, pos)

          cond do
            Map.get(map, {x, y - 1}) == value and Map.get(map, {x - 1, y}) == value ->
              # merge region2 into region1
              region1 = Map.get(p2r, {x, y - 1})
              points1 = Map.get(r2p, region1)

              {region2, p2r} = Map.pop(p2r, {x - 1, y})
              {points2, r2p} = Map.pop(r2p, region2)

              p2r =
                Enum.reduce(points2, p2r, fn point2, acc ->
                  Map.put(acc, point2, region1)
                end)

              p2r = Map.put(p2r, {x, y}, region1)
              merged_points = MapSet.union(points1, points2)
              merged_points = MapSet.put(merged_points, pos)

              r2p = Map.put(r2p, region1, merged_points)
              {p2r, r2p}

            Map.get(map, {x, y - 1}) == value ->
              neighbor_region = Map.get(p2r, {x, y - 1})
              p2r = Map.put(p2r, pos, neighbor_region)
              rp = Map.get(r2p, neighbor_region)
              rp = MapSet.put(rp, pos)
              r2p = Map.put(r2p, neighbor_region, rp)
              {p2r, r2p}

            Map.get(map, {x - 1, y}) == value ->
              neighbor_region = Map.get(p2r, {x - 1, y})
              p2r = Map.put(p2r, pos, neighbor_region)
              rp = Map.get(r2p, neighbor_region)
              rp = MapSet.put(rp, pos)
              r2p = Map.put(r2p, neighbor_region, rp)
              {p2r, r2p}

            true ->
              # else create a new region
              region = make_ref()
              p2r = Map.put(p2r, pos, region)
              r2p = Map.put(r2p, region, MapSet.new([pos]))
              {p2r, r2p}
          end
        end)
      end)

    {pos2region, region2pos}
  end

  def p2(file) do
    def p1(file) do
      {_pos2region, region2pos} = build_maps(file)

      region2pos
      |> Enum.map(&get_area_and_sides/1)
      |> Enum.map(fn {a, s} -> a * s end)
      |> Enum.sum()
    end
  end

  defp get_area_and_sides({_region, points}) do
    {area(points), corners(points)}
  end

  defp corners(points) do
    Enum.reduce(points, 0, fn point, acc ->
      if is_corner?(point, points) do
        acc + 1
      else
        acc
      end
    end)
  end
  
  defp is_corner?(point, points) do
    # outer
    #up and left out
    # up and right
    # right and bottom
    # left and bottom
    
    #inner
    #up-right
    #up-left
    #bottom-left
    #bootpm-right
    cond do
      (not En)
    end
  end
end
