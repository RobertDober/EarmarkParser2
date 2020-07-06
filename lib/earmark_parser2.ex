defmodule EarmarkParser2 do
  use EarmarkParser2.Types
  alias EarmarkParser2.{AstCtxt, AstNode, Error, Lexer, Options, Parser}

  @type input_t :: list(String.t()) | String.t()
  @type options_t :: Options.t() | map() | Keyword.t()

  @moduledoc """
  Coming Soon
  """

  @crlf ~r{\n\r?}
  @doc """
  Coming even sooner
  """
  @spec as_ast(input_t(), Options.options_t()) :: result_t()
  def as_ast(lines, options \\ %Options{})

  def as_ast(lines, options) when is_binary(lines) do
    lines
    |> String.split(@crlf)
    |> _as_ast(Options.new(options))
  end

  def as_ast(lines, options) do
    _as_ast(lines, Options.new(options))
  end

  @default_timeout_in_ms 5000
  @spec _as_ast(list(String.t()), Options.t()) :: result_t()
  defp _as_ast(lines, options)

  defp _as_ast(lines, options) do
    lines
    |> Stream.zip(Stream.iterate(1, &(&1 + 1)))
    |> Enum.to_list()
    |> _pflat_map(&_tokenize_numbered_line/1, options.timeout || @default_timeout_in_ms)
    |> _make_ctxt(options)
    |> Parser.parse()
    |> _format_result()
  end

  @spec _format_result(AstCtxt.t()) :: result_t()
  defp _format_result(ast_ctxt) do
    case ast_ctxt do
      %AstCtxt{ast: ast, messages: messages, status: status} ->
        {status, ast |> AstNode.to_tuples(), messages}
    end
  end

  defp _join_pmap_results_or_raise(yield_tuples, timeout)

  defp _join_pmap_results_or_raise({_task, {:ok, result}}, _timeout) do
    result
  end

  defp _join_pmap_results_or_raise({task, {:error, reason}}, _timeout) do
    raise(Error, "#{inspect(task)} has died with reason #{inspect(reason)}")
  end

  defp _join_pmap_results_or_raise({task, nil}, timeout) do
    raise(
      Error,
      "#{inspect(task)} has not responded within the set timeout of #{timeout}ms, consider increasing it"
    )
  end

  @spec _make_ctxt(token_ts(), options_t()) :: AstCtxt.t()
  defp _make_ctxt(tokens, options) do
    AstCtxt.new(options: options, tokens: tokens)
  end

  @spec _pflat_map(list(), (any() -> any()), number()) :: any()
  defp _pflat_map(collection, func, timeout) do
    collection
    |> Enum.map(fn item -> Task.async(fn -> func.(item) end) end)
    |> Task.yield_many(timeout)
    |> Enum.flat_map(&_join_pmap_results_or_raise(&1, timeout))
  end

  @spec _tokenize_numbered_line(numbered_line_t()) :: token_ts()
  defp _tokenize_numbered_line({line, lnb}) do
    [{:nl, "", len: 0, lnb: lnb} | Lexer.tokenize(line, lnb: lnb)]
  end
end
