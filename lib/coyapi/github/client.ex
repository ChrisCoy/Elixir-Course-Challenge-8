defmodule Coyapi.Github.Client do
  alias Coyapi.Error

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.Headers, [{"User-Agent", "Tesla HTTP Client"}]
  plug Tesla.Middleware.JSON

  def get_repos_by_username(username) do
    "/users/#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}), do: body

  defp handle_get({:ok, %Tesla.Env{status: 404}}), do: Error.build(:not_found, "Not Found")

  defp handle_get({:error, reason}), do: Error.build(:bad_request, reason)
end
