defmodule Bonfire.Editor.Quill do
  use Bonfire.UI.Common.Web, :stateless_component

  prop field_name, :string, default: "html_body"
  prop placeholder, :string, default: ""
  prop content, :string, default: ""
  prop smart_input_opts, :list, default: []
  prop insert_text, :string, default: nil
  prop textarea_class, :css_class, default: nil
  prop thread_mode, :any, default: nil
  prop showing_within, :any, default: nil
  prop advanced_mode, :boolean, default: false

  # needed by apps to use this editor to know how to process text they receive from it
  def output_format, do: :html
end
