defmodule PerbualanWeb.Router do
  use PerbualanWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :user_session do
    plug(PerbualanWeb.Plugs.LoadUser)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PerbualanWeb do
    pipe_through [:browser, :user_session]

    get "/", PageController, :index
    get "/register", UserController, :register
    get "/login", UserController, :login
    post "/session", UserController, :session
    resources "/users", UserController, only: [:create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", PerbualanWeb do
  #   pipe_through :api
  # end
end
