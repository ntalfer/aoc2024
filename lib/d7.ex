defmodule D7 do
  def p1(file) do
    operators = [&Kernel.+/2, &Kernel.*/2]
    solve(operators, file)
  end

  def p2(file) do
    operators = [&Kernel.+/2, &Kernel.*/2, &String.to_integer("#{&1}#{&2}")]
    solve(operators, file)
  end

  defp solve(operators, file) do
    file
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split([":", " "], trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Task.async_stream(fn [res | numbers] ->
      if possibly_true?(operators, res, numbers) do
        res
      else
        0
      end
    end)
    |> Enum.reduce(0, fn {:ok, n}, acc -> acc + n end)
  end

  def possibly_true?(_, res, [n]) do
    res == n
  end

  def possibly_true?(operators, res, [n1, n2 | rest]) do
    Enum.any?(operators, fn op ->
      possibly_true?(operators, res, [op.(n1, n2) | rest])
    end)
  end
end
