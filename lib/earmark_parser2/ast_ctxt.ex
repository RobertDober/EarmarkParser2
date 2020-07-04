defmodule EarmarkParser2.AstCtxt do
  @moduledoc false

  alias EarmarkParser2.Options

  defstruct options: %Options{}

  @type t :: %__MODULE__{
          options: Options.t()
        }
end
