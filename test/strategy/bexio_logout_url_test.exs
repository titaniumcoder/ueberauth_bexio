defmodule Ueberauth.Strategy.Bexio.LogoutUrlTest do
  use ExUnit.Case, async: false
  use Plug.Test

  import Mock

  alias Ueberauth.Strategy.Bexio

  @site "https://auth.bexio.com/realms/bexio/.well-known/openid-configuration"
  @end_session "https://auth.bexio.com/realms/bexio/protocol/openid-connect/logout"

  defp discovery_response(body, code \\ 200) do
    {:ok, %OAuth2.Response{status_code: code, body: body}}
  end

  defp with_discovery(body, fun) when is_map(body) do
    with_mock(OAuth2.Client, [:passthrough],
      get: fn _client, @site, _headers, _opts -> discovery_response(body) end
    ) do
      fun.()
    end
  end

  test "returns the end_session_endpoint from the discovery document without options" do
    with_discovery(%{"end_session_endpoint" => @end_session}, fn ->
      assert Bexio.logout_url() == @end_session
    end)
  end

  test "encodes optional params as query string" do
    with_discovery(%{"end_session_endpoint" => @end_session}, fn ->
      url =
        Bexio.logout_url(
          client_id: "my_client",
          post_logout_redirect_uri: "https://myapp.example.com/logged_out?lang=de",
          id_token_hint: "eyJhbGciOiJIUzI1NiJ9.payload.sig"
        )

      assert String.starts_with?(url, @end_session <> "?")

      query = URI.decode_query(URI.parse(url).query)

      assert query["client_id"] == "my_client"
      assert query["post_logout_redirect_uri"] == "https://myapp.example.com/logged_out?lang=de"
      assert query["id_token_hint"] == "eyJhbGciOiJIUzI1NiJ9.payload.sig"
    end)
  end

  test "skips nil values" do
    with_discovery(%{"end_session_endpoint" => @end_session}, fn ->
      assert Bexio.logout_url(client_id: "my_client", post_logout_redirect_uri: nil) ==
               @end_session <> "?client_id=my_client"
    end)
  end

  test "returns nil when the discovery document has no end_session_endpoint" do
    with_discovery(%{"issuer" => "https://auth.bexio.com/realms/bexio"}, fn ->
      assert Bexio.logout_url() == nil
    end)
  end

  test "returns nil when discovery fails" do
    with_mock(OAuth2.Client, [:passthrough],
      get: fn _client, @site, _headers, _opts ->
        {:error, %OAuth2.Error{reason: :timeout}}
      end
    ) do
      assert Bexio.logout_url() == nil
    end
  end

  test "returns nil when discovery returns an error status" do
    with_mock(OAuth2.Client, [:passthrough],
      get: fn _client, @site, _headers, _opts -> discovery_response(%{}, 500) end
    ) do
      assert Bexio.logout_url() == nil
    end
  end

  test "raises on unknown options" do
    assert_raise ArgumentError, ~r/unknown options \[:state\]/, fn ->
      Bexio.logout_url(state: "xyz")
    end
  end
end
