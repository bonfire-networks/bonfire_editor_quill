defmodule Bonfire.Editor.Quill.BrowserCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a full browser.

  If the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MyAppWeb.FeatureCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import Bonfire.Editor.Quill.BrowserCase
      alias Wallaby.Query
      alias Wallaby.Browser

      import Bonfire.UI.Common.Testing.Helpers
      import Bonfire.Editor.Quill.Test.FakeHelpers
      import Untangle

      @moduletag :e2e

      @endpoint Application.compile_env!(:bonfire, :endpoint_module)

      setup _ do
        on_exit(fn -> Application.put_env(:wallaby, :js_logger, :stdio) end)
      end

      def user_browser_session(session) do
        username = System.get_env("ADMIN_USER", "test_user")
        pw = System.get_env("ADMIN_PASSWORD", "for-testing-only")
        account = fake_account!(%{credential: %{password: pw}})

        user =
          fake_user!(account, %{
            username: username,
            name: username
          })

        # alice = fake_user!()
        # conn = conn(user: alice)
        # conn = Phoenix.ConnTest.get(conn, "/")
        # %{@cookie_key => %{value: token}} = conn.resp_cookies

        user_session =
          session
          |> visit("/login")
          |> fill_in(Query.fillable_field("login_fields[email_or_username]"),
            with: username
          )
          |> fill_in(Query.fillable_field("login_fields[password]"), with: pw)
          # |> Browser.send_keys([:enter])
          |> click(Query.button("Log in"))

        # |> Browser.set_cookie(@cookie_key, token)
      end

      def new_post(session, text \\ "Hello world") do
        session
        # |> visit("/feed")
        # |> fill_in(text_field("#editor_quill .ql-editor"), with: text)
        |> click(Query.css("#editor .ql-editor"))
        |> Browser.send_keys([text])
        |> click(Query.button("Post"))
        # |> assert_has(css(".alert", text: "Posted!"))
        |> assert_text(Query.css("article"), text)
      end
    end
  end

  def enable_latency_sim(session, latency) do
    Application.put_env(:wallaby, :js_logger, nil)

    Wallaby.Browser.execute_script(
      session,
      "liveSocket.enableLatencySim(#{latency})"
    )
  end

  def disable_latency_sim(session) do
    Wallaby.Browser.execute_script(session, "liveSocket.disableLatencySim()")
  end
end
