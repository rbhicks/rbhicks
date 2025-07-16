defmodule Rbhicks.BlogTest do
  use Rbhicks.DataCase

  alias Rbhicks.Blog

  describe "blog_posts" do
    alias Rbhicks.Blog.BlogPost

    import Rbhicks.BlogFixtures

    @invalid_attrs %{title: nil, content: nil}

    test "list_blog_posts/0 returns all blog_posts" do
      blog_post = blog_post_fixture()
      assert Blog.list_blog_posts() == [blog_post]
    end

    test "get_blog_post!/1 returns the blog_post with given id" do
      blog_post = blog_post_fixture()
      assert Blog.get_blog_post!(blog_post.id) == blog_post
    end

    test "create_blog_post/1 with valid data creates a blog_post" do
      valid_attrs = %{title: "some title", content: "some content"}

      assert {:ok, %BlogPost{} = blog_post} = Blog.create_blog_post(valid_attrs)
      assert blog_post.title == "some title"
      assert blog_post.content == "some content"
    end

    test "create_blog_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_blog_post(@invalid_attrs)
    end

    test "update_blog_post/2 with valid data updates the blog_post" do
      blog_post = blog_post_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content"}

      assert {:ok, %BlogPost{} = blog_post} = Blog.update_blog_post(blog_post, update_attrs)
      assert blog_post.title == "some updated title"
      assert blog_post.content == "some updated content"
    end

    test "update_blog_post/2 with invalid data returns error changeset" do
      blog_post = blog_post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_blog_post(blog_post, @invalid_attrs)
      assert blog_post == Blog.get_blog_post!(blog_post.id)
    end

    test "delete_blog_post/1 deletes the blog_post" do
      blog_post = blog_post_fixture()
      assert {:ok, %BlogPost{}} = Blog.delete_blog_post(blog_post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_blog_post!(blog_post.id) end
    end

    test "change_blog_post/1 returns a blog_post changeset" do
      blog_post = blog_post_fixture()
      assert %Ecto.Changeset{} = Blog.change_blog_post(blog_post)
    end
  end
end
