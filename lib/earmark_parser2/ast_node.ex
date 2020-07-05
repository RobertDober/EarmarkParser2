defmodule EarmarkParser2.AstNode do
  @moduledoc false
  use EarmarkParser2.Types

  defstruct atts: [],
            content: [],
            meta: %{},
            parent: nil,
            tag: :new


  @type content_t :: t() | String.t()
  @type content_ts :: list(content_t())

  @type t :: %__MODULE__{
          atts: ast_att_ts(),
          content: content_ts(),
          meta: map(),
          parent: maybe(t),
          tag: String.t()
        }


  @spec to_tuple(content_t()) :: ast_tuple_t()
  def to_tuple(ast_nody)

  def to_tuple(%__MODULE__{tag: tag, atts: atts, content: content, meta: meta}) do
    {tag, atts, to_tuples(content, |]), meta}
  end

  def to_tuple(anything_else) do
    anything_else
  end

  # N.B. This is the map/reverse pattern
  #      It can be seen as follows
  #  to_tuples(content) -> content |> map_reverse(&to_tuple)
  #  where
  #  map_reverse(content, fn) -> map_reverse'(content, fn, [])
  #  in
  #  map_reverse'([], _, res) -> res
  #  map_reverse'([h|t],f, res) -> map_reverse'(t, f, [f.(h)|res])
  #
  #  We might find this pattern all over the place and in that case
  #  shall definitely implement it!!!
  defp to_tuples(nodes, result)
  defp to_tuples([nd|nds], result) do
  end
  defp to_tuples([], result) do
    result
  end
end
