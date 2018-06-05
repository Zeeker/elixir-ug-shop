defmodule Shop.Cart do
  defstruct contents: [],
            customer: nil

  def add_product(%__MODULE__{contents: contents} = cart, %Shop.Product{} = product) do
    %__MODULE__{cart | contents: [product | contents]}
  end

  defdelegate total(cart), to: Shop.Cart.Total, as: :calculate
  defdelegate shipping(cart), to: Shop.Cart.Shipping, as: :calculate
end
