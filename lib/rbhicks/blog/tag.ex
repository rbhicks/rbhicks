defmodule Rbhicks.Blog.Tag do
  use Ash.Resource, otp_app: :rbhicks, domain: Rbhicks.Blog, data_layer: AshPostgres.DataLayer

  postgres do
    table "tags"
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
  end
end
