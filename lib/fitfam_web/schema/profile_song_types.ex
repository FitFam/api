defmodule FitFamWeb.Schema.ProfileSongTypes do
  use Absinthe.Schema.Notation

  object :profile_song_queries do

    @desc "Get Spotify access token"
    field :spotify_access_token, :string do
      resolve fn _, _, _ ->
        client_id = System.get_env("SPOTIFY_CLIENT_ID")
        client_secret = System.get_env("SPOTIFY_CLIENT_SECRET")

        code = Base.encode64("#{client_id}:#{client_secret}")
        headers = ["Authorization": "Basic #{code}", "Content-Type": "application/x-www-form-urlencoded"]
        post_body = URI.encode_query(%{ "grant_type" => "client_credentials" })

        case HTTPoison.post("https://accounts.spotify.com/api/token", post_body, headers) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            case Jason.decode(body) do
              {:ok, decoded} -> {:ok, decoded["access_token"]}
              {:error, error} -> {:error, error}
            end
          {:ok, %HTTPoison.Response{status_code: 400, body: body}} ->
            {:error, body}
          {:error, %HTTPoison.Error{reason: reason}} ->
            {:error, reason}
        end

      end
    end

  end
end
