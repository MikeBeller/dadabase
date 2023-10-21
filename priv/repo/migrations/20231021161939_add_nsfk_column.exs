defmodule Dadabase.Repo.Migrations.AddNsfkColumn do
  use Ecto.Migration

  def change do
    alter table(:jokes) do
      add :nsfk, :boolean, default: false
    end

  end
end
