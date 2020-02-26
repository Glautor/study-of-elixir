defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CORSPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/show/:name", PageController, :show
  end

  # Other scopes may use custom stacks.
  scope "/api", HelloWeb do
    pipe_through :api

    post "render_name", PageController, :render_name
  end
end
