defmodule EarmarkParser2.Types do
  @moduledoc """
  Keeps all types of the application in one place!
  """

  defmacro __using__(opts) do
    quote do

      @typep ast_att_t :: {String.t, String.t}
      @typep ast_att_ts :: list(ast_att_t())
      @typep ast_tag_t :: String.t | :comment | :new
      @typep ast_tuple_t :: {ast_tag_t(), ast_att_ts(), ast_tuple_ts(), map()} | String.t
      # This is the exposed type
      @type ast_tuple_ts :: list(ast_tuple_t())
      @type result_t :: {status_t, ast_tuple_ts(), message_ts()}

      @type maybe(t) :: t | nil

      @type message_t :: {:error | :warning, number(), String.t()}
      @type message_ts :: list(message_t())

      @type numbered_line_t :: {String.t(), number()}

      @type status_t :: :ok | :error
      @type token_t :: {atom(), String.t(), len: number(), lnb: number()}
      @type token_ts :: list(token_t)
    end
  end
end
