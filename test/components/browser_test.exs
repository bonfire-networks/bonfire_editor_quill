defmodule Bonfire.Editor.Quill.BrowserTests do
  use Bonfire.Editor.Quill.BrowserCase, async: true
  require Phoenix.ConnTest

  @cookie_key "_bonfire_key"

  def user_browser_session(session) do
    username = System.get_env("ADMIN_USER", "test_user")
    pw = System.get_env("ADMIN_PASSWORD", "for-testing-only")
    account = fake_account!(%{credential: %{password: pw}})
    user = fake_user!(account, %{character: %{username: username}, profile: %{name: username}})

    # alice = fake_user!()
    # conn = conn(user: alice)
    # conn = Phoenix.ConnTest.get(conn, "/")
    # %{@cookie_key => %{value: token}} = conn.resp_cookies

    user_session = session
    |> visit("/login")
    |> fill_in(Query.fillable_field("login_fields[email_or_username]"), with: username)
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

  feature "can publish a simple post", %{session: session} do
    user_browser_session(session)
    |> new_post()
  end

  feature "can post a reply to a post", %{session: session} do
    text = "...and hello to you too"

    user_browser_session(session)
    |> new_post()
    |> click(Query.data("id", "action_reply"))
    |> new_post(text)
    |> Browser.take_screenshot()
  end

end
