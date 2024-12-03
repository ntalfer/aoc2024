defmodule D3Test do
  use ExUnit.Case

  test "p1" do
    assert D3.p1("test/d3.txt") == 174_336_360
  end

  test "p2" do
    assert D3.p2("test/d3.txt") == 88802350
  end
end
