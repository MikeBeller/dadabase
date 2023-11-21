defmodule DadabaseWeb.Router do
  use DadabaseWeb, :router

  def get_user_name_from_conn(conn) do
    case Plug.Conn.get_req_header(conn, "x-replit-user-name") do
      [fst | _rest] -> fst
      _ -> "anonymous"
    end
  end

  def check_replit_user(conn, opts) do
    allowed_ids = Keyword.get(opts, :allowed_ids, [])
    user_id = get_user_name_from_conn(conn)
    IO.puts "user_id: #{user_id} -- allowed: #{inspect(allowed_ids)}"
    if user_id in allowed_ids do
      conn
    else
      conn
      |> send_resp(401, "Unauthorized")
      |> halt()
    end
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DadabaseWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :user_check do
    plug :check_replit_user, allowed_ids: ["miketest3k"]
  end

  scope "/", DadabaseWeb do
    pipe_through [:browser,:user_check]

    live "/", JokeLive.Index, :index
    live "/jokes", JokeLive.Index, :index
    live "/jokes/new", JokeLive.Index, :new
    live "/jokes/:id/edit", JokeLive.Index, :edit

    live "/jokes/:id", JokeLive.Show, :show
    live "/jokes/:id/show/edit", JokeLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", DadabaseWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:dadabase, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    pipeline :admin_check do
      plug :check_replit_user, allowed_ids: ["miketest3k"]
    end

    scope "/dev" do
      pipe_through [:browser, :admin_check]

      live_dashboard "/dashboard", metrics: DadabaseWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
