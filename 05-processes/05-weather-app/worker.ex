defmodule Weather.Worker do
  Mix.install([
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:dotenvy, "~> 0.8"} # load .env file automatically
    ])

  # Load .env at runtime
  # Dotenvy.source!(Path.expand(".env", __DIR__))
  env = Dotenvy.source!(".env")
  System.put_env(env)


  def temperature_of(location) do
    case url_for(location) |> HTTPoison.get() |> parse_response() do
      {:ok, temp} ->
        "#{location}: #{temp}°C"

      {:error, reason} ->
        "#{location} not found (#{reason})"
    end
  end

  defp url_for(location) do
    location = URI.encode(location)

    "https://api.openweathermap.org/data/2.5/weather" <>
      "?q=#{location}&units=metric&appid=#{apikey()}"
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    IO.puts(body)
    body
    |> Jason.decode!()
    |> compute_temperature()
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: code, body: body}}) do
    case Jason.decode(body) do
      {:ok, %{"message" => msg}} -> {:error, "#{code} - #{msg}"}
      _ -> {:error, "HTTP #{code}"}
    end
  end

  defp parse_response({:error, %HTTPoison.Error{reason: reason}}), do: {:error, reason}

  defp compute_temperature(%{"main" => %{"temp" => temp}}), do: {:ok, Float.round(temp, 1)}
  defp compute_temperature(_), do: {:error, "invalid data"}

  defp apikey do
    System.get_env("OPENWEATHER_API_KEY") ||
      raise "Missing OPENWEATHER_API_KEY in environment"
  end
end
