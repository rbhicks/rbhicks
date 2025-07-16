defmodule RbhicksWeb.BlogPostLiveTest do
  use RbhicksWeb.ConnCase

  import Phoenix.LiveViewTest
  import Rbhicks.BlogFixtures

  @create_attrs %{title: "some title", content: "some content"}
  @update_attrs %{title: "some updated title", content: "some updated content"}
  @invalid_attrs %{title: nil, content: nil}
  defp create_blog_post(_) do
    blog_post = blog_post_fixture()

    %{blog_post: blog_post}
  end

  describe "Index" do
    setup [:create_blog_post]

    test "lists all blog_posts", %{conn: conn, blog_post: blog_post} do
      {:ok, _index_live, html} = live(conn, ~p"/blog_posts")

      assert html =~ "Listing Blog posts"
      assert html =~ blog_post.title
    end

    test "saves new blog_post", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/blog_posts")

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Blog post")
               |> render_click()
               |> follow_redirect(conn, ~p"/blog_posts/new")

      assert render(form_live) =~ "New Blog post"

      assert form_live
             |> form("#blog_post-form", blog_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#blog_post-form", blog_post: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/blog_posts")

      html = render(index_live)
      assert html =~ "Blog post created successfully"
      assert html =~ "some title"
    end

    test "updates blog_post in listing", %{conn: conn, blog_post: blog_post} do
      {:ok, index_live, _html} = live(conn, ~p"/blog_posts")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#blog_posts-#{blog_post.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/blog_posts/#{blog_post}/edit")

      assert render(form_live) =~ "Edit Blog post"

      assert form_live
             |> form("#blog_post-form", blog_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#blog_post-form", blog_post: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/blog_posts")

      html = render(index_live)
      assert html =~ "Blog post updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes blog_post in listing", %{conn: conn, blog_post: blog_post} do
      {:ok, index_live, _html} = live(conn, ~p"/blog_posts")

      assert index_live |> element("#blog_posts-#{blog_post.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#blog_posts-#{blog_post.id}")
    end
  end

  describe "Show" do
    setup [:create_blog_post]

    test "displays blog_post", %{conn: conn, blog_post: blog_post} do
      {:ok, _show_live, html} = live(conn, ~p"/blog_posts/#{blog_post}")

      assert html =~ "Show Blog post"
      assert html =~ blog_post.title
    end

    test "updates blog_post and returns to show", %{conn: conn, blog_post: blog_post} do
      {:ok, show_live, _html} = live(conn, ~p"/blog_posts/#{blog_post}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/blog_posts/#{blog_post}/edit?return_to=show")

      assert render(form_live) =~ "Edit Blog post"

      assert form_live
             |> form("#blog_post-form", blog_post: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#blog_post-form", blog_post: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/blog_posts/#{blog_post}")

      html = render(show_live)
      assert html =~ "Blog post updated successfully"
      assert html =~ "some updated title"
    end
  end
end
