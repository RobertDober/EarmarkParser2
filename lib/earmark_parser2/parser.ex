defmodule EarmarkParser2.Parser do
  @moduledoc false

  alias EarmarkParser2.{AstCtxt, AstNode, Options}
  use EarmarkParser2.Types

  @typep ast_t :: AstNode.content_t
  @typep ast_ts :: AstNode.content_ts


  @spec parse(AstCtxt.t()) :: AstCtxt.t()
  def parse(%AstCtxt{ast: ast, tokens: tokens}=ast_ctxt) do
    _parse_new(tokens, ast, ast_ctxt)

  end

  # Precondition Top of ast is new AstNode
  @spec _parse_new(token_ts, ast_ts, AstCtxt.t()) :: AstCtxt.t()
  defp _parse_new(tokens, ast, ast_ctxt)

  defp _parse_new([], ast, ast_ctxt) do
    %{ast_ctxt | ast: ast}
  end
  defp _parse_new(tokens, ast, ast_ctxt) do
    _parse_next(tokens, ast, ast_ctxt)
  end

  @spec _parse_next(token_ts, ast_ts, AstCtxt.t()) :: AstCtxt.t()
  defp _parse_next(tokens, ast, ast_ctxt)
  defp _parse_next([tk|tks], ast, ast_ctxt) do
    _parse_new(tks, [{"???", [], ["???"], %{}}|ast], ast_ctxt) 
  end
end
