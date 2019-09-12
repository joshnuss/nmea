defmodule NmeaTest do
  use ExUnit.Case
  doctest Nmea

  test "greets the world" do
    assert Nmea.hello() == :world
  end
end
