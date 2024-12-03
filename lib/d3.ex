defmodule D3 do
  def p1(file) do
    file
    |> File.read!()
    |> then(fn str -> Regex.scan(~r/mul\((?<x>\d{1,3}),(?<y>\d{1,3})\)/, str, capture: :all) end)
    |> Enum.map(fn [_, x_str, y_str] -> String.to_integer(x_str) * String.to_integer(y_str) end)
    |> Enum.sum()
  end

  def p2(file) do
    file
    |> File.read!()
    |> then(fn str ->
      Regex.scan(~r/do\(\)|don't\(\)|mul\((?<x>[0-9]*),(?<y>[0-9]*)\)/, str, capture: :all)
    end)
    |> Enum.map(fn
      ["do()"] -> :enable
      ["don't()"] -> :disable
      [_, x_str, y_str] -> String.to_integer(x_str) * String.to_integer(y_str)
    end)
    |> Enum.reduce({[], :enable}, &filter/2)
    |> then(fn {list, _} -> Enum.sum(list) end)
  end

  defp filter(:enable, {list, _}) do
    {list, :enable}
  end

  defp filter(:disable, {list, _}) do
    {list, :disable}
  end

  defp filter(_, {list, :disable}) do
    {list, :disable}
  end

  defp filter(elem, {list, :enable}) do
    {[elem | list], :enable}
  end
end
