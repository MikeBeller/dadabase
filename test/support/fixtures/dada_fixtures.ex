defmodule Dadabase.DadaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Dadabase.Dada` context.
  """

  @doc """
  Generate a joke.
  """
  def joke_fixture(attrs \\ %{}) do
    {:ok, joke} =
      attrs
      |> Enum.into(%{
        name: "some name",
        text: "some text"
      })
      |> Dadabase.Dada.create_joke()

    joke
  end
end
