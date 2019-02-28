defmodule PerbualanWeb.Plugs.LoadUser do
  import Plug.Conn
  alias Perbualan.Accounts

  def init(_opts), do: nil

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user_by_id(user_id)

    assign(conn, :current_user, user)
  end
end
