defmodule D9 do
  def p1(file) do
    file
    |> File.read!()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> to_blocks(0, [])

    # |> to_charlist()
    # |> Enum.reverse()
    # |> rearrange()
    # |> checksum()
  end

  # defp to_blocks([], _, acc) do
  #   Enum.join(acc)
  # end
  # defp to_blocks([n1], id, acc) do
  #   acc = [String.duplicate("#{id}", n1) | acc]
  #   to_blocks([], id+1, acc)
  # end
  # defp to_blocks([n1, n2 | rest], id, acc) do
  #   acc = [String.duplicate(".", n2), String.duplicate("#{id}", n1) | acc]
  #   to_blocks(rest, id+1, acc)
  # end

  defp to_blocks([], _, acc) do
    List.flatten(acc)
  end

  defp to_blocks([n1], id, acc) do
    acc = [List.duplicate(id + ?0, n1) | acc]
    to_blocks([], id + 1, acc)
  end

  defp to_blocks([n1, n2 | rest], id, acc) do
    acc = [List.duplicate(?., n2), List.duplicate(id + ?0, n1) | acc]
    to_blocks(rest, id + 1, acc)
  end

  # defp rearrange([?. | rest]) do
  #   rearrange(rest)
  # end
  # defp rearrange([char | rest]) do
  #   case rest |> Enum.reverse() |> Enum.find_index(fn x -> x == ?. end) do
  #       nil ->
  #         [char | rest]
  #         |> Enum.reverse()
  #         |> to_string()
  #       index ->
  #         {list1, [?. | list2]} = Enum.split(rest |> Enum.reverse(), index)
  #         Enum.reverse(list1 ++ [char] ++ list2)
  #         |> rearrange()
  #   end
  # end
  # defp rearrange([char | rest]) do
  #   case :string.rchr(rest,  ?.) do
  #       0 ->
  #         [char | rest]
  #         |> Enum.reverse()
  #         |> to_string()
  #       index ->
  #         {list1, [?. | list2]} = Enum.split(rest, index - 1)
  #         Enum.reverse(list1 ++ [char] ++ list2)
  #         |> rearrange()
  #   end
  # end

  # defp checksum(string) do
  #   string
  #   |> String.split("", trim: true)
  #   |> Enum.map(&String.to_integer/1)
  #   |> Enum.with_index()
  #   |> Enum.reduce(0, fn {value, index}, acc -> acc + index * value end)
  # end

  def p2(file) do
    file
    |> File.read!()
    |> String.split("\n")
  end
end
