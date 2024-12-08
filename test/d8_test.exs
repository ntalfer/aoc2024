defmodule D8Test do
  use ExUnit.Case

  test "p1" do
    assert D8.p1("test/d8.txt") == 320
  end

end
