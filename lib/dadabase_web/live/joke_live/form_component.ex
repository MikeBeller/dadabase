defmodule DadabaseWeb.JokeLive.FormComponent do
  use DadabaseWeb, :live_component

  alias Dadabase.Dada

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage joke records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="joke-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:text]} type="textarea" cols="30" rows="5" label="Text" />
        <.input field={@form[:nsfk]} type="checkbox" label="NSFK" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Joke</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{joke: joke} = assigns, socket) do
    changeset = Dada.change_joke(joke)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"joke" => joke_params}, socket) do
    changeset =
      socket.assigns.joke
      |> Dada.change_joke(joke_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"joke" => joke_params}, socket) do
    save_joke(socket, socket.assigns.action, joke_params)
  end

  defp save_joke(socket, :edit, joke_params) do
    case Dada.update_joke(socket.assigns.joke, joke_params) do
      {:ok, joke} ->
        notify_parent({:saved, joke})

        {:noreply,
         socket
         |> put_flash(:info, "Joke updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_joke(socket, :new, joke_params) do
    case Dada.create_joke(joke_params) do
      {:ok, joke} ->
        notify_parent({:saved, joke})

        {:noreply,
         socket
         |> put_flash(:info, "Joke created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
