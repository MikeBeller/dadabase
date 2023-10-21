defmodule Dadabase.Dada do
  @moduledoc """
  The Dada context.
  """

  import Ecto.Query, warn: false
  alias Dadabase.Repo

  alias Dadabase.Dada.Joke

  @doc """
  Fetches the jokes for the main screen -- filtering out nsfk if needed.
  """
  def fetch_jokes(show_nsfk) do
    query = from j in Joke,
            where: ^show_nsfk or j.nsfk == false
    Repo.all(query)
  end

  @doc """
  Returns the list of jokes.

  ## Examples

      iex> list_jokes()
      [%Joke{}, ...]

  """
  def list_jokes do
    Repo.all(Joke)
  end

  @doc """
  Gets a single joke.

  Raises `Ecto.NoResultsError` if the Joke does not exist.

  ## Examples

      iex> get_joke!(123)
      %Joke{}

      iex> get_joke!(456)
      ** (Ecto.NoResultsError)

  """
  def get_joke!(id), do: Repo.get!(Joke, id)

  @doc """
  Creates a joke.

  ## Examples

      iex> create_joke(%{field: value})
      {:ok, %Joke{}}

      iex> create_joke(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_joke(attrs \\ %{}) do
    %Joke{}
    |> Joke.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a joke.

  ## Examples

      iex> update_joke(joke, %{field: new_value})
      {:ok, %Joke{}}

      iex> update_joke(joke, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_joke(%Joke{} = joke, attrs) do
    joke
    |> Joke.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a joke.

  ## Examples

      iex> delete_joke(joke)
      {:ok, %Joke{}}

      iex> delete_joke(joke)
      {:error, %Ecto.Changeset{}}

  """
  def delete_joke(%Joke{} = joke) do
    Repo.delete(joke)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking joke changes.

  ## Examples

      iex> change_joke(joke)
      %Ecto.Changeset{data: %Joke{}}

  """
  def change_joke(%Joke{} = joke, attrs \\ %{}) do
    Joke.changeset(joke, attrs)
  end
end
