defmodule RbhicksWeb.BlogPostLive.Index do
  use RbhicksWeb, :live_view

  alias Rbhicks.Blog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Listing Blog posts
        <:actions>
          <%= if not (@current_scope == nil) and @current_scope.user.role == :admin do %>
            <.button variant="primary" navigate={~p"/blog_posts/new"}>
              <.icon name="hero-plus" /> New Blog post
            </.button>
          <% end %>
        </:actions>
      </.header>

      <.table
        id="blog_posts"
        rows={@streams.blog_posts}
        row_click={fn {_id, blog_post} -> JS.navigate(~p"/blog_posts/#{blog_post}") end}
      >
        <:col :let={{_id, blog_post}} label="Title">{blog_post.title}</:col>
        <:col :let={{_id, blog_post}} label="Content">{blog_post.content}</:col>
        <:action :let={{_id, blog_post}}>
          <div class="sr-only">
            <.link navigate={~p"/blog_posts/#{blog_post}"}>Show</.link>
          </div>
          <%= if not (@current_scope == nil) and @current_scope.user.role == :admin do %>
            <.link navigate={~p"/blog_posts/#{blog_post}/edit"}>Edit</.link>
          <% end %>
        </:action>
        <:action :let={{id, blog_post}}>
          <%= if not (@current_scope == nil) and @current_scope.user.role == :admin do %>
            <.link
              phx-click={JS.push("delete", value: %{id: blog_post.id}) |> hide("##{id}")}
              data-confirm="Are you sure?"
            >
              Delete
            </.link>
          <% end %>
        </:action>
      </.table>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Listing Blog posts")
     |> stream(:blog_posts, Blog.list_blog_posts())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    blog_post = Blog.get_blog_post!(id)
    {:ok, _} = Blog.delete_blog_post(blog_post)

    {:noreply, stream_delete(socket, :blog_posts, blog_post)}
  end
end
