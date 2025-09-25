defmodule Bonfire.Editor.Quill.BrowserTests do
  use Bonfire.Editor.Quill.BrowserCase, async: true
  require Phoenix.ConnTest

  @cookie_key "_bonfire_key"

  @tag :browser
  feature "can publish a simple post", %{session: session} do
    user_browser_session(session)
    |> new_post()
  end

  @tag :browser
  feature "can post a reply to a post", %{session: session} do
    text = "...and hello to you too"

    user_browser_session(session)
    |> new_post()
    |> click(Query.data("id", "action_reply"))
    |> new_post(text)
    |> Browser.take_screenshot()
  end
end
