defmodule Bonfire.Editor.Quill do
  use Bonfire.UI.Common.Web, :stateless_component

  prop field_name, :string
  prop placeholder, :string
  prop content, :string
  prop smart_input_text, :string, default: ""
  prop insert_text, :any
  prop textarea_class, :string
  prop thread_mode, :string
  prop showing_within, :string
  
  def output_format, do: :html # needed by apps to use this editor to know how to process text they receive from it

end
