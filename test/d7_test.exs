defmodule D7Test do
  use ExUnit.Case

  test "p1" do
    assert D7.p1("test/d7.txt") == 2_664_460_013_123
  end

  test "p2" do
    assert D7.p2("test/d7.txt") == 426_214_131_924_213
  end
end
