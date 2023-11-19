defmodule Coyapi.User do
  alias Ecto.Changeset
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_params [:email, :senha]
  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "users" do
    field :email, :string
    field :senha, :string, virtual: true
    field :senha_hash, :string

    timestamps(type: :utc_datetime)
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{senha: pw}} = changeset) do
    %{password_hash: senha_hash} = Pbkdf2.add_hash(pw)
    change(changeset, %{senha_hash: senha_hash})
  end

  defp put_password_hash(changeset), do: changeset
end
