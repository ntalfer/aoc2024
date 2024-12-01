defmodule D1Test do
  use ExUnit.Case

  test "p1" do
    assert D1.p1("test/d1.txt") == 2_970_687
  end

  test "p2" do
    assert D1.p2("test/d1.txt") == 23_963_899
  end
end
