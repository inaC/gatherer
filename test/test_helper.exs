ExUnit.start()

Mox.defmock(Gatherer.MockHttpClient, for: Gatherer.HttpClient.Api)
Application.put_env(:gatherer, :http_client, Gatherer.MockHttpClient)
