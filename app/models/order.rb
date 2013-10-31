class Order < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class_name: 'OrderItem'

  validates :customer_id, presence: true
  validates :items, length: { minimum: 1 }, if: :completed?

  scope :open, -> { where completed: false }
  scope :completed, -> { where completed: true }

  def total
    s = 0

    items.each do |i|
      v = i.value
      q = i.quantity
      t = v * q

      s = s + t
    end

    s
  end

  def check_validity!
    if through_reflection.nil?
      raise StandardError.new(active_record.name, self)
    end

    if through_reflection.options[:polymorphic]
      raise StandardError.new(active_record.name, self)
    end

    if source_reflection.nil?
      raise StandardError.new(self)
    end

    check_validity_of_inverse!
  end
end
