defmodule RbhicksWeb.BlogPostLive.Form do
  use RbhicksWeb, :live_view

  alias Rbhicks.Blog
  alias Rbhicks.Blog.BlogPost

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash}>
      <.header>
        {@page_title}
        <:subtitle>Use this form to manage blog_post records in your database.</:subtitle>
      </.header>

      <.form for={@form} id="blog_post-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:content]} type="text" label="Content" />
        <footer>
          <.button phx-disable-with="Saving..." variant="primary">Save Blog post</.button>
          <.button navigate={return_path(@return_to, @blog_post)}>Cancel</.button>
        </footer>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    blog_post = Blog.get_blog_post!(id)

    socket
    |> assign(:page_title, "Edit Blog post")
    |> assign(:blog_post, blog_post)
    |> assign(:form, to_form(Blog.change_blog_post(blog_post)))
  end

  defp apply_action(socket, :new, _params) do
    blog_post = %BlogPost{}

    socket
    |> assign(:page_title, "New Blog post")
    |> assign(:blog_post, blog_post)
    |> assign(:form, to_form(Blog.change_blog_post(blog_post)))
  end

  @impl true
  def handle_event("validate", %{"blog_post" => blog_post_params}, socket) do
    changeset = Blog.change_blog_post(socket.assigns.blog_post, blog_post_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"blog_post" => blog_post_params}, socket) do
    save_blog_post(socket, socket.assigns.live_action, blog_post_params)
  end

  defp save_blog_post(socket, :edit, blog_post_params) do
    case Blog.update_blog_post(socket.assigns.blog_post, blog_post_params) do
      {:ok, blog_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blog post updated successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, blog_post))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_blog_post(socket, :new, blog_post_params) do
    case Blog.create_blog_post(blog_post_params) do
      {:ok, blog_post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Blog post created successfully")
         |> push_navigate(to: return_path(socket.assigns.return_to, blog_post))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _blog_post), do: ~p"/blog_posts"
  defp return_path("show", blog_post), do: ~p"/blog_posts/#{blog_post}"
end
