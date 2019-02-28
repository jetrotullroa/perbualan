defmodule PerbualanWeb.UserController do
  use PerbualanWeb, :controller

  alias Perbualan.Accounts
  alias Perbualan.Accounts.User

  def register(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "register.html", changeset: changeset)
  end

  def create(conn, %{"registration" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(
          :info,
          "Successfully created user #{user.username}. Please login using your credentials."
        )
        |> redirect(to: "/login")

      {:error, changeset} ->
        conn
        |> render("register.html", changeset: changeset)
    end
  end

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def session(conn, %{"session" => session_data}) do
    case Accounts.get_user_by_credentials(session_data) do
      {:error, error} ->
        conn
        |> put_flash(:error, error)
        |> render("login.html")

      {:ok, user} ->
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> put_flash(:info, "Login successful!")
        |> redirect(to: "/")
    end
  end
end
