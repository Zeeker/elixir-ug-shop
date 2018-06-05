defmodule Shop.Shipping do
  def calculate(%Shop.Cart{contents: contents}) do
    contents
    |> Enum.map(& &1.weight)
    |> Enum.sum()
  end
end
