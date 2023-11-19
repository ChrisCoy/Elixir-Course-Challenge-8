defmodule CoyapiWeb.RepositoryController do
  alias Coyapi.Repository.Get

  use CoyapiWeb, :controller

  def show(conn, params) do
    # conn |> put_status(200) |> text("hello world")
    username = Map.get(params, "username")
    repos = Get.by_username(username)

    json(conn, %{message: repos})
  end
end
