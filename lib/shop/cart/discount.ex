defmodule Shop.Cart.Discount do
  alias Shop.Customer

  def get(%Shop.Cart{customer: customer, coupon: coupon}) do
    for_customer(customer) + for_coupon(customer, coupon)
  end

  defp for_customer(%Customer{premium: true}), do: 0.1
  defp for_customer(_customer), do: 0

  defp for_coupon(%Customer{premium: true}, coupon) when is_integer(coupon), do: coupon / 200
  defp for_coupon(_customer, coupon) when is_integer(coupon), do: coupon / 100
  defp for_coupon(_customer, _coupon), do: 0
end
