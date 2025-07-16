defmodule Rbhicks.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Rbhicks.Repo

  alias Rbhicks.Blog.BlogPost

  @doc """
  Returns the list of blog_posts.

  ## Examples

      iex> list_blog_posts()
      [%BlogPost{}, ...]

  """
  def list_blog_posts do
    BlogPost
    |> sort()
    |> Repo.all()
  end

  def list_blog_posts(opts) do
    BlogPost
    |> sort(opts)
    |> Repo.all()
  end

  @doc """
  Gets a single blog_post.

  Raises `Ecto.NoResultsError` if the Blog post does not exist.

  ## Examples

      iex> get_blog_post!(123)
      %BlogPost{}

      iex> get_blog_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_blog_post!(id), do: Repo.get!(BlogPost, id)

  @doc """
  Creates a blog_post.

  ## Examples

      iex> create_blog_post(%{field: value})
      {:ok, %BlogPost{}}

      iex> create_blog_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_blog_post(attrs) do
    %BlogPost{}
    |> BlogPost.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a blog_post.

  ## Examples

      iex> update_blog_post(blog_post, %{field: new_value})
      {:ok, %BlogPost{}}

      iex> update_blog_post(blog_post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_blog_post(%BlogPost{} = blog_post, attrs) do
    blog_post
    |> BlogPost.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a blog_post.

  ## Examples

      iex> delete_blog_post(blog_post)
      {:ok, %BlogPost{}}

      iex> delete_blog_post(blog_post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_blog_post(%BlogPost{} = blog_post) do
    Repo.delete(blog_post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking blog_post changes.

  ## Examples

      iex> change_blog_post(blog_post)
      %Ecto.Changeset{data: %BlogPost{}}

  """
  def change_blog_post(%BlogPost{} = blog_post, attrs \\ %{}) do
    BlogPost.changeset(blog_post, attrs)
  end

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:updated_at] and sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query) do
    query
    |> order_by({:desc, :updated_at})
  end
end
