defmodule D4Test do
  use ExUnit.Case

  test "p1" do
    assert D4.p1("test/d4.txt") == 2468
  end

  test "p2" do
    assert D4.p2("test/d4.txt") == 1864
  end
end
