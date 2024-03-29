defmodule NMEATest do
  use ExUnit.Case
  doctest NMEA

  test "parse empty text fails" do
    assert NMEA.parse(nil) == {:error, :invalid}
    assert NMEA.parse("") == {:error, :invalid}
  end

  test "parse invalid checksum fails" do
    assert NMEA.parse("$GPRMC,,V,,,,,,,,,,N*52") == {:error, :checksum}
  end

  test "parse succeeds when checksum is valid" do
    assert NMEA.parse("$GPGSV,3,1,12,01,,,23,02,,,23,03,,,22,05,,,23*7C") ==
             {:ok,
              {"GP", "GSV",
               [
                 "3",
                 "1",
                 "12",
                 "01",
                 "",
                 "",
                 "23",
                 "02",
                 "",
                 "",
                 "23",
                 "03",
                 "",
                 "",
                 "22",
                 "05",
                 "",
                 "",
                 "23"
               ]}}
  end

  test "with zero padded checksum" do
    assert NMEA.parse("$IIMWV,332.8,R,15.5,M,A*05") ==
             {:ok, {"II", "MWV", ["332.8", "R", "15.5", "M", "A"]}}
  end
end
