defmodule Bonfire.EditorQuill.Integration do
  alias Bonfire.Common.Config
  alias Bonfire.Common.Utils
  import Where

  def repo, do: Config.get!(:repo_module)


end
