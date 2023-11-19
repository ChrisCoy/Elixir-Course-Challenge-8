defmodule Coyapi.Error do
  @keys [:status, :result]
  @enforce_keys @keys
  @derive {Jason.Encoder, only: @keys}
  defstruct @keys

  def build(status, result) do
    %__MODULE__{
      status: status,
      result: result
    }
  end
end
