defmodule Unit.TokenLexer.SingleTokensTest do
  use Support.LexerTest
  
  describe "all the single tokens:" do
    [
      {:bar, "|"},
      {:bquote, "`"},
      {:bquote, "```"},
      {:bquote, "````"},
      {:close_tag, "</end>"},
      {:colon, ":"},
      {:dash, "--"},
      {:dash, "---"},
      {:dquote, "\""},
      {:header, "# "},
      {:header, "## "},
      {:header, "###### "},
      {:lacc, "{"},
      {:lbracket, "["},
      {:lparen, "("},
      {:ol_header, "1. "},
      {:ol_header, "012345678.  "},
      {:open_ial, "{:"},
      {:open_tag, "<html>"},
      {:racc, "}"},
      {:rbracket, "]"},
      {:rparen, ")"},
      {:squote, "'"},
      {:star, "*"},
      {:star, "**"},
      {:star, "****"},
      {:tag_pfx, "<hello"},
      {:tag_sfx, ">"},
      {:tag_sfx, " >"},
      {:tilde, "~"},
      {:tilde, "~~"},
      {:ul_header, "- "},
      {:ul_header, "-  "},
      {:ul_header, "* "},
      {:ul_header, "*  "},
      {:underscore, "_"},
      {:underscore, "___"},
      {:void_tag, "<br/>"},
      {:void_tag, "<br />"},
      {:void_tag_sfx, "/>"},
      {:void_tag_sfx, " />"},
      {:ws, "  "},
      {:ws, " "}
    ]
    |> Enum.each(fn {token, content} ->
      quote do
        unquote do
          test ~s{token #{token} with "#{content}"} do
            expected = [{unquote(token), unquote(content), len: String.length(unquote(content))}]

            assert tokenize(unquote(content)) == expected
          end

          test ~s{escaped token #{token} becomes a text with "#{content}"} do
            escaped_input = unquote(content) |> String.graphemes |> Enum.map(&("\\#{&1}")) |> Enum.join
            expected = [{:text, unquote(content), [len: 2*String.length(unquote(content))]}]

            assert tokenize(escaped_input) == expected
          end
        end
      end
    end)
  end

  describe "escapes, as they escaped from above of course" do
    test "a single escape" do
      input    = "\\"
      expected = [{:escape, "\\", len: 1}]

      assert tokenize(input) == expected
    end

    test "first escape escapes second" do
      input    = "\\\\"
      expected = [{:text, "\\", len: 2}]

      assert tokenize(input) == expected
    end
  end
end
