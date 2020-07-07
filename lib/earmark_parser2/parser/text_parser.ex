defmodule EarmarkParser2.Parser.TextParser do
  @moduledoc false
  use EarmarkParser2.Types
  alias EarmarkParser2.{AstCtxt, AstNode, Parser}

  @typep tuple_t :: Parser.parse_tuple_t()
  @typep continuation_t :: (tuple_t() -> tuple_t()) 

  @spec parse_text(tuple_t(), continuation_t()) :: tuple_t()
  def parse_text(tuple, continuation)

  def parse_text({[tk | tks], ast, ast_ctxt}, continuation) do
    continuation.({tks, AstNode.add_to_top(ast, tk), ast_ctxt})
  end
end
