defmodule Coyapi.Repository.Get do
  alias Coyapi.Repository
  alias Coyapi.Github.Client
  alias Coyapi.Error

  def by_username(username) do
    # username
    # |> Client.get_repos_by_username()

    case Client.get_repos_by_username(username) do
      %Error{} = error ->
        error

      repos ->
        Enum.map(repos, fn repo ->
          %Repository{
            id: repo["id"],
            description: repo["description"],
            html_url: repo["owner"]["html_url"],
            name: repo["name"],
            stargazers_count: repo["stargazers_count"]
          }
        end)
    end

    # |> Enum.map(fn repo -> %Repository{} end)
    # |> Enum.map(fn repo -> repo end)
  end
end
