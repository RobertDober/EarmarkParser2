defmodule Unit.TokenLexer.TokenTest do
  use ExUnit.Case, async: true

  import EarmarkParser2.Lexer
  alias EarmarkParser2.Token, as: T

  describe "html tags" do
    test "vanilla" do
      input = "<br />"
      expected = [
        %T{content: "<br />", len: 6, lnb: 42, token: :void_tag}
      ]

      assert tokenize(input, lnb: 42) == expected
    end

  end

end
