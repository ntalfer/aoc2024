defmodule D5Test do
  use ExUnit.Case

  test "p1" do
    assert D5.p1("test/d5.txt") == 6267
  end

  test "p2" do
    assert D5.p2("test/d5.txt") == 5184
  end

end
