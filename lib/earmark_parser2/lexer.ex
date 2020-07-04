defmodule EarmarkParser2.Lexer do
  @moduledoc false


  @type partial_token_t :: {atom(), String.t, len: number()} 
  @type partial_token_ts :: list(partial_token_t)
  @type token_t :: {atom(), String.t, len: number(), lnb: number()} 
  @type token_ts :: list(token_t)

  @spec tokenize(String.t, lnb: number()) :: token_ts
  def tokenize(line, lnb: lnb) do
    elex line, lnb: lnb, with: :token_lexer
  end
  

  @spec elex(String.t, lnb: number, with: atom()) :: token_ts
  defp elex(text, options)

  defp elex(text, lnb: lnb, with: lexer) do
    lex(text, with: lexer)
    |> Enum.map(&triple_elixirize(&1, lnb: lnb))
  end

  @spec lex(String.t, with: atom()) :: partial_token_ts
  defp lex(text, with: lexer) do
    case text
         |> String.to_charlist()
         |> lexer.string() do
      {:ok, tokens, _} -> tokens
    end
  end


  @spec triple_elixirize({atom(), charlist(), [len: number()]}, lnb: number()) :: token_t()
  defp triple_elixirize({token, content, len}, lnb: lnb) do
    {token, to_string(content), len: len, lnb: lnb}
  end
end

# SPDX-License-Identifier: Apache-2.0
