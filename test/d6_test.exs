defmodule D6Test do
  use ExUnit.Case

  test "p1" do
    assert D6.p1("test/d6.txt") == 4602
  end

  test "p2" do
   assert D6.p2("test/d6.txt") == 1703
  end
end
