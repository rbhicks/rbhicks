defmodule Rbhicks.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string
      add :content, :string

      timestamps(type: :utc_datetime)
    end
  end
end
