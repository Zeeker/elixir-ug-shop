defmodule Shop.Cart do
  defstruct contents: [],
            customer: nil,
            coupon: nil

  alias Shop.Cart.{Shipping, Total}

  def add_product(%__MODULE__{contents: contents} = cart, %Shop.Product{} = product) do
    %__MODULE__{cart | contents: [product | contents]}
  end

  def add_coupon(%__MODULE__{} = cart, coupon) do
    %__MODULE__{cart | coupon: coupon}
  end

  defdelegate total(cart), to: Total, as: :calculate
  defdelegate shipping(cart), to: Shipping, as: :calculate
end
