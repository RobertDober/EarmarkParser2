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
  @type tag_t :: String.t() | :new | :comment | :root

  @type t :: %__MODULE__{
          atts: ast_att_ts(),
          content: content_ts(),
          meta: map(),
          parent: maybe(t),
          tag: tag_t()
        }
  @type ts :: nonempty_list(t())

  
  @spec add_to_top(ts(), content_t()) :: ts() 
  def add_to_top([%__MODULE__{content: content}=top|rest], subject) do
    [%{top | content: [subject | content]}|rest]
  end
  @spec close_node((ts())) :: ts()
  def close_node([node, %__MODULE__{content: content} = parent | rest]) do
    [%{parent | content: [node | content]} | rest]
  end

  @spec new_node(tag_t(), t()) :: t()
  def new_node(tag, parent) do
    %__MODULE__{tag: tag, parent: parent}
  end

  @spec open_node(tag_t(), ts()) :: ts()
  def open_node(tag, [parent | rest]) do
    [new_node(tag, parent), parent | rest]
  end

  @spec to_tuple(content_t()) :: ast_tuple_t()
  def to_tuple(ast_nody)

  def to_tuple(%__MODULE__{tag: tag, atts: atts, content: content, meta: meta}) do
    {tag, atts, _to_tuples(content, []), meta}
  end

  def to_tuple(anything_else) do
    anything_else
  end

  @spec to_tuples(content_ts()) :: ast_tuple_ts()
  def to_tuples(nodes) do
    _to_tuples(nodes, [])
  end

  # N.B. This is the map/reverse pattern
  #      It can be seen as follows
  #  to_tuples(content) -> content |> map_reverse(&to_tuple)
  #
  #  where
  #
  #  map_reverse(content, fn) -> map_reverse'(content, fn, [])
  #
  #  in
  #
  #  map_reverse'([], _, res) -> res
  #  map_reverse'([h|t],f, res) -> map_reverse'(t, f, [f.(h)|res])
  #
  #  We might find this pattern all over the place and in that case
  #  shall definitely implement it!!!
  @spec _to_tuples(content_ts(), ast_tuple_ts()) :: ast_tuple_ts()
  defp _to_tuples(nodes, result)

  defp _to_tuples([nd | nds], result) do
    _to_tuples(nds, [to_tuple(nd) | result])
  end

  defp _to_tuples([], result) do
    result
  end
end
