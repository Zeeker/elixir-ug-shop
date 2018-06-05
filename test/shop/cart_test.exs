defmodule Shop.CartTest do
  use ExUnit.Case, async: true

  alias Shop.{Cart, Product}

  describe ".add_product/2" do
    setup :empty_cart

    test "to an empty cart results in cart with one product", %{cart: cart} do
      product = %Product{name: "My Product!"}

      assert Cart.add_product(cart, product) == %Cart{contents: [product]}
    end
  end

  defp empty_cart(_context) do
    [cart: %Cart{}]
  end
end
