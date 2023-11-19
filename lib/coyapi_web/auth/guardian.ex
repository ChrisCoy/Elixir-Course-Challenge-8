defmodule CoyapiWeb.Auth.Guardian do
  alias Coyapi.Error
  alias Coyapi.Users
  alias Coyapi.User
  use Guardian, otp_app: :coyapi

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(%{"sub" => id}) do
    IO.inspect("resource_from_claims")
    Users.Get.by_id(id)
  end

  def authenticate(%{"id" => id, "senha" => password}) do
    with %User{senha_hash: hash} = user <- Users.Get.by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      nil ->
        {:error, Error.build(:unauthorized, "Please verify your credentials")}

      error ->
        error
    end
  end
end
