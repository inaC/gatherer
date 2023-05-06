defmodule GathererTest do
  use ExUnit.Case
  doctest Gatherer

  test "greets the world" do
    assert Gatherer.hello() == :world
  end
end
