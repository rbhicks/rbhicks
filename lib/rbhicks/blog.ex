defmodule Rbhicks.Blog do
  use Ash.Domain,
    otp_app: :rbhicks

  resources do
    resource Rbhicks.Blog.Post
  end
end
