defmodule Gatherer.HttpClient do
  alias Gatherer.HttpClient.Api

  @behaviour Api

  @impl Api
  def get(url) do
    url
    |> impl().get()
    |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    {:ok, %{body: body, status_code: status_code}}
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp impl do
    Application.get_env(:gatherer, :http_client, HTTPoison)
  end
end
