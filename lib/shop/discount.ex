defmodule Shop.Discount do
  def get(%Shop.Cart{customer: customer}) do
    for_customer(customer)
  end

  defp for_customer(%Shop.Customer{premium: true}), do: 0.1
  defp for_customer(_customer), do: 0
end
