defmodule Coyapi.Repo.Migrations.ChangeSenhaColumnName do
  use Ecto.Migration

  def change do
    rename table(:users), :senha, to: :senha_hash
  end
end
