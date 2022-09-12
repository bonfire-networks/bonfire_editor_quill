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
