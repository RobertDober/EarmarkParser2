defmodule EarmarkParser2.Lexer do
  @moduledoc false

  use EarmarkParser2.Types
  alias EarmarkParser2.Token

  @typep partial_token_t :: {atom(), String.t(), len: number()}
  @typep partial_token_ts :: list(partial_token_t)

  @spec tokenize(String.t(), lnb: number()) :: Token.ts()
  def tokenize(line, lnb: lnb) do
    elex(line, lnb: lnb, with: :token_lexer)
  end

  @spec elex(String.t(), lnb: number, with: atom()) :: Token.ts()
  defp elex(text, options)

  defp elex(text, lnb: lnb, with: lexer) do
    lex(text, with: lexer)
    |> Enum.map(&_make_token(&1, lnb: lnb))
  end

  @spec lex(String.t(), with: atom()) :: partial_token_ts
  defp lex(text, with: lexer) do
    case text
         |> String.to_charlist()
         |> lexer.string() do
      {:ok, tokens, _} -> tokens
    end
  end

  @spec _make_token({atom(), charlist(), [len: number()]}, lnb: number()) :: Token.t()
  defp _make_token({token, content, len}, lnb: lnb) do
    %Token{
      content: to_string(content),
      len: len,
      lnb: lnb,
      token: token
    }
  end
end

# SPDX-License-Identifier: Apache-2.0
