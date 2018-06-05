defmodule Shop.Cart.Total do
  def calculate(%Shop.Cart{} = cart) do
    discount = Shop.Cart.Discount.get(cart)

    cart.contents
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> Kernel.*(1 - discount)
  end
end
