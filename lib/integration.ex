defmodule Bonfire.Editor.Quill.Integration do
  alias Bonfire.Common.Config
  alias Bonfire.Common.Utils
  import Untangle

  def repo, do: Config.get!(:repo_module)
end
