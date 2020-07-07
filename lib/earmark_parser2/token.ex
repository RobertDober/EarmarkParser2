defmodule EarmarkParser2.Token do
  @moduledoc false
  use EarmarkParser2.Types

  defstruct content: "",
            len: 0,
            lnb: 0,
            token: ""

  @type t :: %__MODULE__{
          content: String.t(),
          len: number(),
          lnb: number(),
          token: atom()
        }

  @type ts :: list(t())

  @spec nl(number()) :: t()
  def nl(lnb) do
    %__MODULE__{lnb: lnb, token: :nl}
  end
end
