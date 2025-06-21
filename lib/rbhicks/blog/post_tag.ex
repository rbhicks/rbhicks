defmodule Rbhicks.Blog.PostTag do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "post_tags"
    repo Rbhicks.Repo
  end
  actions do
    defaults [:create, :read, :destroy]
  end

  relationships do
    belongs_to :post, Rbhicks.Blog.Post do
      primary_key? true
      allow_nil? false
    end

    belongs_to :tag, Rbhicks.Blog.Tag do
      primary_key? true
      allow_nil? false
    end
  end
end
