defmodule CoyapiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :coyapi

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  # plug Guardian.Plug.LoadResource
end
