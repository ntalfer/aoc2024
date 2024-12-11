defmodule D11Test do
  use ExUnit.Case

  test "p1" do
    assert D11.p1("test/d11.txt") == 233050
  end

  # @tag timeout: :infinity
  # test "p2" do
  #  assert D11.p2("test/d11.txt") == 0
  # end
end
