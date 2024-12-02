defmodule D2Test do
  use ExUnit.Case

  test "p1" do
    assert D2.p1("test/d2.txt") == 257
  end

  test "p2" do
    assert D2.p2("test/d2.txt") == 328
  end
end
