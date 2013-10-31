require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "saves the product value on create" do
    product = products(:one)
    item    = order_items(:one).dup
    item.value = nil
    item.save!

    assert_equal product.value, item.value
  end

  test "calculates item total based on value and quantity" do
    assert_equal 19.98, order_items(:one).total
    assert_equal 15.99, order_items(:two).total
  end
end
