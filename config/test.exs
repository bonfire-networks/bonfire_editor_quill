import Config

# NOTE: make sure to put something similar (update the otp name!) in you're parent app's config/test.exs

config :bonfire, sql_sandbox: true

config :wallaby,
  # base_url: Bonfire.Web.Endpoint.url(),
  otp_app: :bonfire_ui_common,
  screenshot_on_failure: true,
  chromedriver: [
    # point to your chromedriver path
    path: "assets/node_modules/chromedriver/bin/chromedriver",
    # change to false if you want to see the browser in action
    headless: true
  ]
