defmodule Rbhicks.Blog do
  use Ash.Domain,
    otp_app: :rbhicks

  resources do
    resource Rbhicks.Blog.Post
    # resource Rbhicks.Blog.Tag
    # resource Rbhicks.Blog.PostTag
  end
end
