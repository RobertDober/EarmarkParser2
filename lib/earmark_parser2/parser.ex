defmodule EarmarkParser2.Parser do
  @moduledoc false

  use EarmarkParser2.Types
  alias EarmarkParser2.{AstCtxt, Options}

  @spec parse(token_ts(), Options.t) :: ast_ts()
  def parse(tokens, options) do
    :ok
    # _parse(tokens, %AstCtxt{options: options})
  end
end
