defmodule Perbualan.Repo do
  use Ecto.Repo,
    otp_app: :perbualan,
    adapter: Ecto.Adapters.Postgres
end
