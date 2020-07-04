defmodule EarmarkParser2.Lexer do
  @moduledoc false

  def tokenize(line, lnb: lnb) do
    elex line, lnb: lnb, with: :token_lexer
  end
  

  defp elex(text, options)

  defp elex(text, lnb: lnb, with: lexer) do
    lex(text, with: lexer)
    |> Enum.map(&triple_elixirize(&1, lnb: lnb))
  end

  defp lex(text, with: lexer) do
    case text
         |> String.to_charlist()
         |> lexer.string() do
      {:ok, tokens, _} -> tokens
    end
  end


  defp triple_elixirize({token, content, len}, lnb: lnb) do
    {token, to_string(content), len: len, lnb: lnb}
  end
end

# SPDX-License-Identifier: Apache-2.0
