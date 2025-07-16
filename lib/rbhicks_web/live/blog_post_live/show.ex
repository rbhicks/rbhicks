defmodule RbhicksWeb.BlogPostLive.Show do
  use RbhicksWeb, :live_view

  alias Rbhicks.Blog

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        Blog post {@blog_post.id}
        <:subtitle>This is a blog_post record from your database.</:subtitle>
        <:actions>
          <.button navigate={~p"/blog_posts"}>
            <.icon name="hero-arrow-left" />
          </.button>
          <.button variant="primary" navigate={~p"/blog_posts/#{@blog_post}/edit?return_to=show"}>
            <.icon name="hero-pencil-square" /> Edit blog_post
          </.button>
        </:actions>
      </.header>

      <.list>
        <:item title="Title">{@blog_post.title}</:item>
        <:item title="Content">{@blog_post.content}</:item>
      </.list>
    </Layouts.app>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Show Blog post")
     |> assign(:blog_post, Blog.get_blog_post!(id))}
  end
end
