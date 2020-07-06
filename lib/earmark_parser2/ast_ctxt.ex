defmodule EarmarkParser2.AstCtxt do
  @moduledoc false

  use EarmarkParser2.Types
  alias EarmarkParser2.{AstNode, Options}

  defstruct messages: [],
            ast: [],
            options: %Options{},
            state: :new,
            status: :ok,
            tokens: []

  @type ast_ts :: list(AstNode.t() | ast_tuple_t())
  @type t :: %__MODULE__{
          messages: message_ts(),
          ast: AstNode.content_ts(),
          options: Options.t(),
          state: atom(),
          status: status_t(),
          tokens: ast_tuple_ts()
        }

  @spec new(options: Options.t(), tokens: token_ts()) :: t()
  def new(options: options, tokens: tokens) do
    %__MODULE__{
      options: options,
      tokens: tokens
    }
    |> with_new()
  end

  @spec pop_token(t()) :: t()
  def pop_token(%__MODULE__{tokens: [_|tokens]}=ast_ctxt) do
    %{ast_ctxt| tokens: tokens}
  end

  @spec to_tuples(t) :: ast_tuple_ts()
  def to_tuples(%__MODULE__{ast: ast}) do
    ast
    |> Enum.map(&AstNode.to_tuple/1)
  end

  @spec with_new(t()) :: t()
  def with_new( ast_ctxt \\ %__MODULE__{})
  def with_new(%__MODULE__{ast: ast} = ast_ctxt) do
    %{ast_ctxt | ast: [%AstNode{tag: :root} | ast]}
  end
end
