defmodule D11Test do
  use ExUnit.Case

  test "p1" do
    assert D11.p1("test/d11.txt") == 233050
  end

  # test "p2" do
  #  assert D11.p2("test/d11.txt") == 276661131175807
  # end
end
