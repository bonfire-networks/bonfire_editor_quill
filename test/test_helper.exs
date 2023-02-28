ExUnit.start(exclude: Bonfire.Common.RuntimeConfig.skip_test_tags())

Ecto.Adapters.SQL.Sandbox.mode(
  Bonfire.Common.Config.repo(),
  :manual
)

Application.put_env(:wallaby, :base_url, Bonfire.Web.Endpoint.url())

chromedriver_path = Bonfire.Common.Config.get([:wallaby, :chromedriver, :path])
# TODO: skip browser-based tests if no driver is available
if chromedriver_path && File.exists?(chromedriver_path),
  do: {:ok, _} = Application.ensure_all_started(:wallaby),
  else: IO.inspect("Note: Wallaby UI tests will not run because the chromedriver is missing")
