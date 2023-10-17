defmodule Dadabase.Dada.Joke do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jokes" do
    field :name, :string
    field :text, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(joke, attrs) do
    joke
    |> cast(attrs, [:name, :text])
    |> validate_required([:name, :text])
  end
end
