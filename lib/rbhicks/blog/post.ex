defmodule Rbhicks.Blog.Post do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "posts"
    repo Rbhicks.Repo
  end
end
