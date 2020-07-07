defmodule EarmarkParser2.Parser do
  @moduledoc false

  alias EarmarkParser2.{AstCtxt, AstNode, Options, Token}
  alias EarmarkParser2.Parser.{TextParser}
  use EarmarkParser2.Types

  @typep ast_t :: AstNode.content_t()
  @typep ast_ts :: AstNode.content_ts()

  @type parse_tuple_t :: {token_ts(), AstNode.ts(), AstCtxt.t()}

  @spec parse(AstCtxt.t()) :: AstCtxt.t()
  def parse(%AstCtxt{ast: ast, tokens: [_ | tokens]} = ast_ctxt) do
    # IO.inspect(ast, label: :parse)
    {_tokens, [%AstNode{content: ast} | _], ast_ctxt} = _parse_new({tokens, ast, ast_ctxt})
    %{ast_ctxt | ast: ast}
  end

  @spec _parse_header(parse_tuple_t()) :: parse_tuple_t()
  defp _parse_header(parse_tuple)

  defp _parse_header({tokens, ast, ast_ctxt} = parse_tuple) do
    case _eol?(tokens) do
      {true, tokens1} ->
        _parse_new({tokens1, AstNode.close_node(ast), ast_ctxt})

      _ ->
        TextParser.parse_text(parse_tuple, &_parse_header/1)
    end
  end

  defp _parse_next_in_header(parse_tuple)

  defp _parse_next_in_header({[tk | tks], [%{content: content} = current | _] = ast, ast_ctxt}) do
    _parse_header({tks, AstNode.add_to_top(ast, tk.content), ast_ctxt})
  end

  # Precondition Top of ast is new AstNode
  @spec _parse_new(parse_tuple_t()) :: parse_tuple_t()
  defp _parse_new(parse_tuple)

  defp _parse_new({[], ast, ast_ctxt}) do
    {[], ast, ast_ctxt}
  end

  defp _parse_new({tokens, ast, ast_ctxt}) do
    _parse_new_line({tokens, ast, ast_ctxt})
  end

  @spec _parse_new_line(parse_tuple_t()) :: parse_tuple_t()
  defp _parse_new_line(parse_tuple)

  defp _parse_new_line({[%{token: :header, len: len} | tokens], ast, ast_ctxt}) do
    # IO.inspect(ast, label: :new_line_detected_header)
    ast1 = AstNode.open_node("h#{len - 1}", ast)
    _parse_header({tokens, ast1, ast_ctxt})
  end

  defp _parse_new_line({[tk | tks], ast, ast_ctxt}) do
    # IO.inspect({tk, ast}, label: :unexpected)
    {[], ast, AstCtxt.add_error(ast_ctxt, {:error, tk.lnb, "Unexpected token: #{tk.token}"})}
  end

  @spec _eol?(Token.ts()) :: {boolean(), Token.ts()}
  defp _eol?(tokens)

  defp _eol?([]) do
    {true, []}
  end

  defp _eol?([%Token{token: :nl} | rest]) do
    {true, rest}
  end

  defp _eol?(tokens) do
    {false, tokens}
  end
end
