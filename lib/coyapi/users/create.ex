defmodule Coyapi.Users.Create do
  alias Coyapi.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
