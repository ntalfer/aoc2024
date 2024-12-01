defmodule D1 do
  def p1(file) do
    file
    |> build_lists()
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip_reduce(0, fn [a, b], acc -> acc + abs(b - a) end)
  end

  def p2(file) do
    [l1, l2] = build_lists(file)
    freq = Enum.frequencies(l2)
    Enum.reduce(l1, 0, fn a, acc -> acc + a * Map.get(freq, a, 0) end)
  end

  defp build_lists(file) do
    file
    |> File.stream!(:line)
    |> Enum.reduce([[], []], fn line, [l1, l2] ->
      [a, b] =
        line
        |> String.split()
        |> Enum.map(&String.to_integer/1)

      [[a | l1], [b | l2]]
    end)
  end
end
