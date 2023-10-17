defmodule Dadabase.Repo do
  use Ecto.Repo,
    otp_app: :dadabase,
    adapter: Ecto.Adapters.SQLite3
end
