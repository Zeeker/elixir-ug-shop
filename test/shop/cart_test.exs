defmodule Shop.CartTest do
  use ExUnit.Case, async: true

  alias Shop.{Cart, Product, Customer}

  describe ".add_product/2" do
    setup :empty_cart

    test "to no products results in cart with one product", %{cart: cart} do
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

  describe ".total/1 for a premium customer cart" do
    setup [:empty_cart, :add_premium_customer]

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

  describe ".shipping/1" do
    setup :empty_cart

    test "with no products is 0", %{cart: cart} do
      assert Cart.shipping(cart) == 0
    end

    test "with some products weighing 15 kilos is 15", %{cart: cart} do
      cart =
        cart
        |> Cart.add_product(%Product{weight: 3})
        |> Cart.add_product(%Product{weight: 7})
        |> Cart.add_product(%Product{weight: 5})

      assert Cart.shipping(cart) == 15
    end

    test "for a premium customer does not reduce shipping", %{cart: cart} do
      cart =
        cart
        |> Cart.add_product(%Product{weight: 3})
        |> Cart.add_product(%Product{weight: 7})
        |> Cart.add_product(%Product{weight: 5})

      assert Cart.shipping(cart) == 15
    end
  end

  describe ".total/1 with a 10% coupon and a standard customer" do
    setup [:empty_cart, :add_standard_customer, :add_products_for_15_euros]

    test "with some products reduces the total", %{cart: cart} do
      cart = Cart.add_coupon(cart, 10)

      assert Cart.total(cart) == 15 * 0.9
    end
  end

  describe ".total/1 with a 10% coupon and a premium customer" do
    setup [:empty_cart, :add_premium_customer, :add_products_for_15_euros]

    test "with some products reduces the total but 10% and only by half of the coupon", %{
      cart: cart
    } do
      cart = Cart.add_coupon(cart, 10)

      assert Cart.total(cart) == 15 * 0.85
    end
  end

  defp empty_cart(_context) do
    [cart: %Cart{}]
  end

  defp add_standard_customer(%{cart: cart}) do
    [cart: %Cart{cart | customer: %Customer{}}]
  end

  defp add_premium_customer(%{cart: cart}) do
    customer = %Customer{premium: true}

    [cart: %Cart{cart | customer: customer}]
  end

  defp add_products_for_15_euros(%{cart: cart}) do
    cart =
      cart
      |> Cart.add_product(%Product{price: 3})
      |> Cart.add_product(%Product{price: 7})
      |> Cart.add_product(%Product{price: 5})

    [cart: cart]
  end
end
