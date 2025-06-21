defmodule Rbhicks.Blog.Tag do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "tags"
    repo Rbhicks.Repo
  end
end
