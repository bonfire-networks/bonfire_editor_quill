defmodule Bonfire.Editor.Quil.BrowserTests do
  use Bonfire.Editor.Quill.BrowserCase, async: true
  require Phoenix.ConnTest

  @cookie_key "_bonfire_key"

  feature "can publish a simple post", %{session: session} do
    question_text = "How do I test simple things with Wallaby?"

    alice = fake_user!()
    conn = conn(user: alice)
    conn = Phoenix.ConnTest.get(conn, "/")

    %{@cookie_key => %{value: token}} = conn.resp_cookies

    session
    |> visit("/login")
    |> Wallaby.Browser.set_cookie(@cookie_key, token)
    |> visit("/feed")
    # |> click(link("New Question"))
    |> fill_in(text_field("Text"), with: question_text)
    |> click(button("Post"))
    |> assert_has(css(".alert", text: "Posted!"))
    # |> assert_has(css("#questions > tr > td", text: question_text))
  end

end
