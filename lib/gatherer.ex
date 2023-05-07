defmodule Gatherer do
  alias Gatherer.HttpClient

  @moduledoc """
  Documentation for `Gatherer`.
  """

  @doc """
  Fetches a page with the given url and returns a map containing the following keys:

  - assets: a list of urls present in `<img>` tags on the page
  - links: a list of urls present in `<a>` tags on the page

  ## Examples

      iex> Gatherer.fetch("https://www.globo.com")
      {:ok,
        %{
          assets: [
            "https://s3.glbimg.com/v1/AUTH_fd78dc4be9404a2e92b908ade306e9e6/prod/push_web_svgs/notifications-24-px.svg",
            "https://s3.glbimg.com/v1/AUTH_fd78dc4be9404a2e92b908ade306e9e6/prod/header_menu_svgs/menu-button.svg",
            "https://s3.glbimg.com/v1/AUTH_fd78dc4be9404a2e92b908ade306e9e6/prod/header_svgs/logo-globoplay.svg",
          ],
          links: [
            "https://www.globo.com/",
            "https://vitrine.globo.com/?origemId=2528&utm_source=globo.com&utm_medium=header&utm_campaign=vitrine",
          ]
        }
      }

      iex> Gatherer.fetch("localhost")
      {:error, :econnrefused}

  """

  @spec fetch(String.t()) ::
          {:ok, %{assets: list(String.t()), links: list(String.t())}} | {:error, String.t()}
  def fetch(url) do
    with {:ok, %{body: document}} <- HttpClient.get(url),
         {:ok, parsed_document} <- Floki.parse_document(document) do
      {:ok, process(parsed_document)}
    end
  end

  defp process(parsed_document) do
    %{}
    |> Map.put(:assets, get_assets(parsed_document))
    |> Map.put(:links, get_links(parsed_document))
  end

  defp get_assets(parsed_document) do
    parsed_document
    |> Floki.find("img")
    |> Floki.attribute("src")
  end

  defp get_links(parsed_document) do
    parsed_document
    |> Floki.find("a")
    |> Floki.attribute("href")
  end
end
