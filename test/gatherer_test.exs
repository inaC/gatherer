defmodule GathererTest do
  alias Gatherer
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "fetch/1" do
    test "returns the anchor urls and image urls" do
      expect(Gatherer.MockHttpClient, :get, fn _url ->
        html = """
        <html>
          <body>
            <a href="http://example.com">Example</a>
            <img src="http://example.com/example.jpg" alt="Example image">
          </body>
        </html>
        """

        {:ok, %HTTPoison.Response{body: html, status_code: 200}}
      end)

      assert {:ok, %{assets: ["http://example.com/example.jpg"], links: ["http://example.com"]}} ==
               Gatherer.fetch("https://www.google.com")
    end

    test "returns empty list for anchor urls when there are none one the page" do
      expect(Gatherer.MockHttpClient, :get, fn _url ->
        html = """
        <html>
          <body>
            <img src="http://example.com/example.jpg" alt="Example image">
          </body>
        </html>
        """

        {:ok, %HTTPoison.Response{body: html, status_code: 200}}
      end)

      assert {:ok, %{assets: ["http://example.com/example.jpg"], links: []}} ==
               Gatherer.fetch("https://www.google.com")
    end

    test "returns empty list for image urls when there are none one the page" do
      expect(Gatherer.MockHttpClient, :get, fn _url ->
        html = """
        <html>
          <body>
            <a href="http://example.com">Example</a>
          </body>
        </html>
        """

        {:ok, %HTTPoison.Response{body: html, status_code: 200}}
      end)

      assert {:ok, %{assets: [], links: ["http://example.com"]}} ==
               Gatherer.fetch("https://www.google.com")
    end

    test "returns error when failing to get the content" do
      expect(Gatherer.MockHttpClient, :get, fn _url ->
        {:error, %HTTPoison.Error{reason: :econnrefused}}
      end)

      assert {:error, :econnrefused} ==
               Gatherer.fetch("https://www.google.com")
    end
  end
end
