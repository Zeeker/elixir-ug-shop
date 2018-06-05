defmodule Shop.Cart do
  defstruct contents: [],
            customer: nil

  def add_product(%__MODULE__{contents: contents} = cart, %Shop.Product{} = product) do
    %__MODULE__{cart | contents: [product | contents]}
  end

  def total(%__MODULE__{contents: contents, customer: customer}) do
    contents
    |> Enum.map(& &1.price)
    |> Enum.sum()
    |> apply_discount_for_customer(customer)
  end

  defp apply_discount_for_customer(total, %Shop.Customer{premium: true}) do
    total * 0.9
  end

  defp apply_discount_for_customer(total, _customer) do
    total
  end
end
