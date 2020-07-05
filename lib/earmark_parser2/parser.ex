defmodule EarmarkParser2.Parser do
  @moduledoc false

  use EarmarkParser2.Types
  alias EarmarkParser2.{AstCtxt, Options}

  @spec parse(token_ts(), Options.t) :: AstCtxt.t
  def parse([_|tokens], options) do
    ast_ctxt = AstCtxt.new(options: options, tokens: tokens)
    _parse_new(ast_ctxt)
  end

  # Precondition Top of ast is new AstNode
  @spec _parse_new(AstCtxt.t) :: AstCtxt.t
  defp _parse_new(ast_ctxt)
  defp _parse_new(ast_ctxt) do
    ast_ctxt
  end
end
