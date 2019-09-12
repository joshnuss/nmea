defmodule NMEA.MixProject do
  use Mix.Project

  def project do
    [
      app: :nmea,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Parser for NMEA sensor protocol",
      package: [
        maintainers: ["Joshua Nussbaum"],
        licenses: ["MIT"],
        links: %{github: "https://github.com/joshnuss/nmea"}
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
