defmodule NMEATest do
  use ExUnit.Case
  doctest NMEA

  test "greets the world" do
    assert NMEA.hello() == :world
  end
end
