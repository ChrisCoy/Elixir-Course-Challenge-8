defmodule Coyapi.Repo do
  use Ecto.Repo,
    otp_app: :coyapi,
    adapter: Ecto.Adapters.Postgres
end
