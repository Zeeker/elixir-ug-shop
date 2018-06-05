defmodule Shop.Cart do
  defstruct contents: []

  def add_product(%__MODULE__{contents: contents} = cart, %Shop.Product{} = product) do
    %__MODULE__{cart | contents: [product | contents]}
  end

  def total(%__MODULE__{contents: contents}) do
    contents
    |> Enum.map(& &1.price)
    |> Enum.sum()
  end
end
