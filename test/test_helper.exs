ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Bonfire.Common.Config.get!(:repo_module), :manual)

Application.put_env(:wallaby, :base_url, Bonfire.Web.Endpoint.url())

if File.exists?(Bonfire.Common.Config.get([:wallaby, :chromedriver, :path])), do: {:ok, _} = Application.ensure_all_started(:wallaby)
