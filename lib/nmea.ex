defmodule NMEA do
  @moduledoc """
  Parser for NMEA 0183 Version 2.3.
  NMEA 0183 is a combined electrical and data specification for communication between marine electronics such as echo sounder, sonars, anemometer, gyrocompass, autopilot, GPS receivers and many other types of instruments
  More information on [Wikipedia](https://en.wikipedia.org/wiki/NMEA_0183)
  """

  import Bitwise, only: [bxor: 2]

  @doc """
  Parse a datagram.

  ## Examples

      iex> NMEA.parse("$GPRMC,,V,,,,,,,,,,N*53")
      {:ok, {"GP", "RMC", ["", "V", "", "", "", "", "", "", "", "", "", "N"]}}

  """
  def parse("$" <> <<talker::binary-size(2)>> <> <<type::binary-size(3)>> <> rest) do
    [data, checksum] = String.split(rest, "*")

    case valid?(talker <> type <> data, checksum) do
      true ->
        [_ | values] = String.split(data, ",")

        {:ok, {talker, type, values}}

      _ ->
        {:error, :checksum}
    end
  end

  def parse(_), do: {:error, :invalid}

  defp valid?(text, checksum) do
    expected =
      text
      |> String.to_charlist()
      |> Enum.reduce(0, &bxor/2)

    expected == String.to_integer(checksum, 16)
  end
end
