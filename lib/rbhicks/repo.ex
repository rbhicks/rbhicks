defmodule Rbhicks.Repo do
  use Ecto.Repo,
    otp_app: :rbhicks,
    adapter: Ecto.Adapters.Postgres
end
