defmodule Coyapi.Users.Get do
  alias Coyapi.{Repo, User}

  def by_id(id) do
    Repo.get_by(User, id: id)
  end

  def by_email(email) do
    Repo.get_by(User, email: email)
  end
end
