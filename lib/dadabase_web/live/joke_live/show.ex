defmodule DadabaseWeb.JokeLive.Show do
  use DadabaseWeb, :live_view

  alias Dadabase.Dada

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:joke, Dada.get_joke!(id))}
  end

  defp page_title(:show), do: "Show Joke"
  defp page_title(:edit), do: "Edit Joke"
end
