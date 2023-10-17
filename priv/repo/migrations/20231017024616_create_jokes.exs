defmodule Dadabase.Repo.Migrations.CreateJokes do
  use Ecto.Migration

  def change do
    create table(:jokes) do
      add :name, :string
      add :text, :string

      timestamps(type: :utc_datetime)
    end
  end
end
