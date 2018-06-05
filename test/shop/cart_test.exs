defmodule Shop.CartTest do
  use ExUnit.Case, async: true

  alias Shop.{Cart, Product, User}

  describe ".add_product/2" do
    setup :empty_cart

    test "to an empty cart results in cart with one product", %{cart: cart} do
      product = %Product{name: "My Product!"}

      assert Cart.add_product(cart, product) == %Cart{contents: [product]}
    end
  end

  describe ".total/1" do
    setup :empty_cart

    test "with no products is 0", %{cart: cart} do
      assert Cart.total(cart) == 0
    end

    test "with some products is the sum of the product prices", %{cart: cart} do
      cart =
        cart
        |> Cart.add_product(%Product{price: 10})
        |> Cart.add_product(%Product{price: 5})

      assert Cart.total(cart) == 15
    end
  end

  describe ".total/1 for a premium user cart" do
    setup [:empty_cart, :add_premium_user]

    test "with no products is still 0", %{cart: cart} do
      assert Cart.total(cart) == 0
    end

    test "with some products has a discount of 10%", %{cart: cart} do
      cart =
        cart
        |> Cart.add_product(%Product{price: 10})
        |> Cart.add_product(%Product{price: 5})

      assert Cart.total(cart) == 15 * 0.9
    end
  end

  defp empty_cart(_context) do
    [cart: %Cart{}]
  end

  defp add_premium_user(%{cart: cart}) do
    user = %User{premium: true}

    [cart: %Cart{cart | user: user}]
  end
end
