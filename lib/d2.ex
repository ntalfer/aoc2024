defmodule D2 do
  def p1(file) do
    file
    |> reports()
    |> Stream.filter(&safe_report_p1?/1)
    |> Enum.count()
  end

  defp reports(file) do
    file
    |> File.stream!(:line)
    |> Stream.map(fn line ->
      line |> String.split() |> Enum.map(&String.to_integer/1)
    end)
  end

  def safe_report_p1?(report) do
    safe_report_p1?(report, :asc) or safe_report_p1?(report, :desc)
  end

  def safe_report_p1?([], _) do
    true
  end

  def safe_report_p1?([_], _) do
    true
  end

  def safe_report_p1?([a, b | rest], :asc) when a < b and b - a <= 3 do
    safe_report_p1?([b | rest], :asc)
  end

  def safe_report_p1?([a, b | rest], :desc) when a > b and a - b <= 3 do
    safe_report_p1?([b | rest], :desc)
  end

  def safe_report_p1?(_, _) do
    false
  end

  def p2(file) do
    file
    |> reports()
    |> Stream.filter(&safe_report_p2?/1)
    |> Enum.count()
  end

  def safe_report_p2?(report) do
    safe_report_p2?([], report, :asc) or safe_report_p2?([], report, :desc)
  end

  def safe_report_p2?(_, [], _) do
    true
  end

  def safe_report_p2?(_, [_], _) do
    true
  end

  def safe_report_p2?(scanned, [a, b | rest], :asc) when a < b and b - a <= 3 do
    safe_report_p2?(scanned ++ [a], [b | rest], :asc)
  end

  def safe_report_p2?(scanned, [a, b | rest], :desc) when a > b and a - b <= 3 do
    safe_report_p2?(scanned ++ [a], [b | rest], :desc)
  end

  def safe_report_p2?(scanned, [a, b | rest], asc_or_desc) do
    safe_report_p1?(scanned ++ [a | rest], asc_or_desc) or
      safe_report_p1?(scanned ++ [b | rest], asc_or_desc)
  end

  def safe_report_p2?(_, _, _) do
    false
  end
end
