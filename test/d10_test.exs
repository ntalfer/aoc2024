defmodule D10Test do
  use ExUnit.Case

  test "p1" do
    assert D10.p1("test/d10.txt") == 737
  end

  test "p2" do
   assert D10.p2("test/d10.txt") == 1619
  end
end
