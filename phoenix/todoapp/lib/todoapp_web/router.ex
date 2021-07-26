defmodule TodoappWeb.Router do
  use TodoappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoappWeb do
    pipe_through :browser

    # get "/", PageController, :index

    # get "/todos", TodoController, :index
    # get "/todos/new", TodoController, :new
    # post "/todos", TodoController, :create
    # get "/todos/:id", TodoController, :show
    # get "/todos/:id/edit", TodoController, :edit
    # delete "/todos/:id/", TodoController, :delete
    # put "/todos/:id", TodoController, :update
    # patch "/todos/:id", TodoController, :update

    get "/", TodoController, :index
    resources "/todos", TodoController



  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoappWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TodoappWeb.Telemetry
    end
  end
end
