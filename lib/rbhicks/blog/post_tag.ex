defmodule Rbhicks.Blog.PostTag do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "post_tags"
    repo Rbhicks.Repo
  end
end
