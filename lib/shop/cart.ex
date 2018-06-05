defmodule Shop.Cart do
  defstruct contents: [],
            customer: nil

  def add_product(%__MODULE__{contents: contents} = cart, %Shop.Product{} = product) do
    %__MODULE__{cart | contents: [product | contents]}
  end

  def total(%__MODULE__{} = cart) do
    discount = Shop.Discount.get(cart)

    cart.contents
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> Kernel.*(1 - discount)
  end

  defdelegate shipping(cart), to: Shop.Shipping, as: :calculate
end
