defmodule D12Test do
  use ExUnit.Case

  test "p1" do
    assert D12.p1("test/d12.txt") == 1_465_968
  end

  # test "p2" do
  #  assert D12.p2("test/d12.txt") == 0
  # end
end
