require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "calculates order total" do
    assert_equal 35.97, orders(:one).total
    assert_equal 0, orders(:two).total
  end

  test "requires at least one item when completing" do
    order1, order2 = orders(:one, :two)

    assert order1.valid?
    assert order2.valid?

    order1.completed = order2.completed = true

    assert order1.valid?
    assert !order2.valid?

    order2.items << order1.items[0]

    assert order1.valid?
    assert order2.valid?
  end
end
