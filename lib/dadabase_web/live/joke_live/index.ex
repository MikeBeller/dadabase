defmodule DadabaseWeb.JokeLive.Index do
  use DadabaseWeb, :live_view

  alias Dadabase.Dada
  alias Dadabase.Dada.Joke

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :show_nsfk, false)
    {:ok, stream(socket, :jokes, Dada.fetch_jokes(false))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Joke")
    |> assign(:joke, Dada.get_joke!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Joke")
    |> assign(:joke, %Joke{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Jokes")
    |> assign(:joke, nil)
  end

  @impl true
  def handle_info({DadabaseWeb.JokeLive.FormComponent, {:saved, joke}}, socket) do
    {:noreply, stream_insert(socket, :jokes, joke)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    joke = Dada.get_joke!(id)
    {:ok, _} = Dada.delete_joke(joke)

    {:noreply, stream_delete(socket, :jokes, joke)}
  end

  @impl true
  def handle_event("toggle_nsfk", _, socket) do
    show_nsfk = !socket.assigns.show_nsfk
    socket = assign(socket, :show_nsfk, show_nsfk)
    new_jokes = Dada.fetch_jokes(show_nsfk)
    {:noreply, stream(socket, :jokes, new_jokes, reset: true)}
  end
end
