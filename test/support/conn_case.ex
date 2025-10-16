defmodule Bonfire.Editor.Quill.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MyApp.Web.ConnCase, async: System.get_env("TEST_UI_ASYNC") != "no"`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest

      import Bonfire.UI.Common.Testing.Helpers

      import Phoenix.LiveViewTest
      # import Bonfire.Editor.Quill.ConnCase, async: System.get_env("TEST_UI_ASYNC") != "no"

      import Bonfire.Editor.Quill.Test.ConnHelpers
      import Bonfire.Editor.Quill.Test.FakeHelpers

      # alias Bonfire.Editor.Quill.Fake
      # import Bonfire.Editor.Quill.Fake
      # alias Bonfire.Editor.Quill.Web.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint Application.compile_env!(:bonfire, :endpoint_module)

      @moduletag :ui
    end
  end

  setup tags do
    # import Bonfire.Editor.Quill.Integration

    Bonfire.Common.Test.Interactive.setup_test_repo(tags)

    {:ok, []}
  end
end
