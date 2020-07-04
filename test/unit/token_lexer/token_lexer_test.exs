defmodule EarmarkParser2.Unit.TokenLexer.TokenLexerTest do
  use Support.LexerTest

  describe "tokens that are limited in length" do
    test "too long an ol is not an ol" do
      input = "1234567890.  "
      expected = [{:text, "1234567890.", len: 11}, {:ws, "  ", len: 2}]

      assert tokenize(input) == expected
    end

    test "####### The Magnificent 7" do
      input = "#######"
      expected = [{:text, input, len: 7}]

      assert tokenize(input) == expected
    end
  end

  describe "more tokens, but the same" do
    test "some text" do
      input = "c'est ça"

      expected = [
        {:text, "c", len: 1},
        {:squote, "'", len: 1},
        {:text, "est", len: 3},
        {:ws, " ", len: 1},
        {:text, "ça", len: 2}
      ]

      assert tokenize(input) == expected
    end
  end

end
