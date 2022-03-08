defmodule Tsm.Repo do
  use Ecto.Repo,
    otp_app: :tsm,
    adapter: Ecto.Adapters.Postgres
end
