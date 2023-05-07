defmodule Gatherer.HttpClient.Api do
  @doc """
  Defines an interface for making http requests
  """

  @type url :: String.t()
  @type response :: %{
          body: term(),
          status_code: integer()
        }
  @type reason :: String.t()

  @callback get(url()) :: {:ok, response()} | {:error, reason()}
end
