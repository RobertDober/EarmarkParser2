defmodule Unit.TokenLexer.DoubleTroubleTest do
  use Support.LexerTest

  describe "tokens that are scanned for each occurance" do
    [
      {:bar, "|"},
      {:colon, ":"},
      {:dquote, ~s{"}},
      {:escape, "\\"},
      {:lparen, "("},
      {:lacc, "{"},
      {:lbracket, "["},
      {:open_ial, "{:"},
      {:rparen, ")"},
      {:racc, "}"},
      {:rbracket, "]"},
      {:squote, "'"}
    ]
    |> Enum.each(fn {token, string} ->
      quote do
        unquote do
          test ~s{double token: #{token} for "#{string}"} do
            assert_multiple(unquote(token), 2, unquote(string))
          end
        end
      end
    end)
  end
end
