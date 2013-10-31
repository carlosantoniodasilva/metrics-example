class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  before_create :save_value

  # Override default Rails implementation to use 'Item' identifier.
  def self.model_name
    ActiveModel::Name.new(self, nil, 'Item')
  end

  def total
    value * quantity
  end

  private

  def save_value
    self.value = self.product.value
  end
end
