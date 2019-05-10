defmodule PerbualanWeb.PageLive do
  use Phoenix.LiveView
  alias PerbualanWeb.PageView
  alias Perbualan.Accounts
  alias Perbualan.Chats
  alias Perbualan.Chats.Message

  def render(assigns) do
    IO.inspect(assigns)
    PageView.render("index.html", assigns)
  end

  def mount(%{user_id: user_id}, socket) do
    Chats.subscribe()
    {:ok, fetch(socket, user_id)}
  end

  def handle_event("send", %{"message" => message_params}, socket) do
    user = get_user(socket)

    case Chats.create_message(message_params) do
      {:ok, _message} ->
        {:noreply, fetch(socket, user.id)}

      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({Chats, [:message | _], _}, socket) do
    user = get_user(socket)
    {:noreply, fetch(socket, user.id)}
  end

  defp fetch(socket, user_id) do
    current_user = current_user(user_id)
    messages = Chats.list_messages()

    assign(socket, %{
      current_user: current_user,
      messages: messages,
      changeset: user_message_changeset(current_user)
    })
  end

  defp user_message_changeset(user) do
    if user do
      Chats.change_message(%Message{user_id: user.id})
    else
      Chats.change_message(%Message{})
    end
  end

  defp current_user(user_id) do
    if user_id do
      Accounts.get_user_by_id(user_id)
    else
      nil
    end
  end

  defp get_user(socket) do
    socket.assigns
    |> Map.get(:current_user)
  end
end
