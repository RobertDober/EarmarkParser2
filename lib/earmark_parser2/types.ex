defmodule EarmarkParser2.Types do
  @moduledoc """
  Keeps all types of the application in one place!
  """

  defmacro __using__(opts) do
    quote do
      @type ast_ts   :: :ok

      @type maybe(t) :: t | nil

      @type numbered_line_t :: {String.t(), number()}
      @type token_t :: {atom(), String.t(), len: number(), lnb: number()}
      @type token_ts :: list(token_t)
    end
  end
end
