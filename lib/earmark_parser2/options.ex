defmodule EarmarkParser2.Options do

  @moduledoc """
  All available options for the parser
  """
  defstruct breaks: false,
            code_class_prefix: nil,
            footnote_offset: 1,
            footnotes: false,
            gfm: true,
            gfm_tables: false,
            pedantic: false,
            pure_links: true,
            smartypants: true,
            timeout: nil,
            file: "<no file>",
            line: 1

  @type t :: %__MODULE__{
          breaks: boolean,
          code_class_prefix: String.t() | nil,
          footnote_offset: number,
          footnotes: boolean,
          gfm: boolean,
          gfm_tables: boolean(),
          pedantic: boolean,
          pure_links: boolean,
          smartypants: boolean,
          timeout: number() | nil,
          file: String.t(),
          line: number()
        }

  @type options_t :: t() | map() | Keyword.t

  @spec new(options_t()) :: t()
  def new(options)
  def new(options) when is_map(options) do
    struct(__MODULE__, options |> Map.delete(:__struct__) |> Enum.into([]))
  end
  def new(options) when is_list(options) do
    struct(__MODULE__, options)
  end
end

# SPDX-License-Identifier: Apache-2.0
