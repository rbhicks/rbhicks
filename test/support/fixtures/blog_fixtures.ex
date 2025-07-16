defmodule Rbhicks.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rbhicks.Blog` context.
  """

  @doc """
  Generate a blog_post.
  """
  def blog_post_fixture(attrs \\ %{}) do
    {:ok, blog_post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> Rbhicks.Blog.create_blog_post()

    blog_post
  end
end
