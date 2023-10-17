defmodule Dadabase.DadaTest do
  use Dadabase.DataCase

  alias Dadabase.Dada

  describe "jokes" do
    alias Dadabase.Dada.Joke

    import Dadabase.DadaFixtures

    @invalid_attrs %{name: nil, text: nil}

    test "list_jokes/0 returns all jokes" do
      joke = joke_fixture()
      assert Dada.list_jokes() == [joke]
    end

    test "get_joke!/1 returns the joke with given id" do
      joke = joke_fixture()
      assert Dada.get_joke!(joke.id) == joke
    end

    test "create_joke/1 with valid data creates a joke" do
      valid_attrs = %{name: "some name", text: "some text"}

      assert {:ok, %Joke{} = joke} = Dada.create_joke(valid_attrs)
      assert joke.name == "some name"
      assert joke.text == "some text"
    end

    test "create_joke/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dada.create_joke(@invalid_attrs)
    end

    test "update_joke/2 with valid data updates the joke" do
      joke = joke_fixture()
      update_attrs = %{name: "some updated name", text: "some updated text"}

      assert {:ok, %Joke{} = joke} = Dada.update_joke(joke, update_attrs)
      assert joke.name == "some updated name"
      assert joke.text == "some updated text"
    end

    test "update_joke/2 with invalid data returns error changeset" do
      joke = joke_fixture()
      assert {:error, %Ecto.Changeset{}} = Dada.update_joke(joke, @invalid_attrs)
      assert joke == Dada.get_joke!(joke.id)
    end

    test "delete_joke/1 deletes the joke" do
      joke = joke_fixture()
      assert {:ok, %Joke{}} = Dada.delete_joke(joke)
      assert_raise Ecto.NoResultsError, fn -> Dada.get_joke!(joke.id) end
    end

    test "change_joke/1 returns a joke changeset" do
      joke = joke_fixture()
      assert %Ecto.Changeset{} = Dada.change_joke(joke)
    end
  end
end
