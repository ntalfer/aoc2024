defmodule D11 do
  def p1(file) do
    solve(file, 25)
  end

  defp solve(file, times) do
    stones =
      file
      |> File.read!()
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    1..times
    |> Enum.reduce(stones, fn _, s -> shift(s, []) end)
    |> List.flatten()
    |> Enum.count()
  end

  defp shift([], acc) do
    acc
  end

  defp shift([0 | stones], acc) do
    shift(stones, [1 | acc])
  end

  defp shift([list | stones], acc) when is_list(list) do
    [list | stones]
    |> Task.async_stream(fn l -> shift(l, []) end)
    |> Enum.reduce(acc, fn {:ok, r}, acc -> [r | acc] end)
  end

  defp shift([n | stones], acc) do
    digits = Integer.digits(n)
    count = Enum.count(digits)

    if rem(count, 2) == 0 do
      {list1, list2} = Enum.split(digits, div(count, 2))
      shift(stones, [Integer.undigits(list1), Integer.undigits(list2) | acc])
    else
      shift(stones, [n * 2024 | acc])
    end
  end

  def p2(file) do
    solve(file, 75)
  end
end
