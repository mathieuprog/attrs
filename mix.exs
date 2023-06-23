defmodule Attrs.MixProject do
  use Mix.Project

  @version "0.3.0"

  def project do
    [
      app: :attrs,
      elixir: "~> 1.9",
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),

      # Hex
      version: @version,
      package: package(),
      description: "Unifying atom and string key handling for user data (attrs maps) given to Ecto's cast function",

      # ExDoc
      name: "Attrs",
      source_url: "https://github.com/mathieuprog/attrs",
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.29", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      licenses: ["Apache-2.0"],
      maintainers: ["Mathieu Decaffmeyer"],
      links: %{
        "GitHub" => "https://github.com/mathieuprog/attrs",
        "Sponsor" => "https://github.com/sponsors/mathieuprog"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}"
    ]
  end
end
