defmodule Rbhicks.Blog.Post do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "posts"
    repo Rbhicks.Repo
  end

  actions do
    defaults [:read]

    create :create
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      allow_nil? false
      public? true
    end
    
    attribute :body, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    has_many :tag_relationships, Rbhicks.Blog.PostTag

    many_to_many :tags, Rbhicks.Blog.Tag do
      join_relationship :tag_relationships
      destination_attribute_on_join_resource :tag_id
    end
  end
end
