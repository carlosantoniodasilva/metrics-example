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

      # Useless stuff
      a = 1
      b = 2
      c = 3
      z = a + b + c

      if z == 6
        a = a + 1
        b = b + 2
        c = c + 3
        z = a + b + c
      end

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

    if options[:source_type] && source_reflection.options[:polymorphic].nil?
      raise StandardError.new(active_record.name, self, source_reflection)
    end

    if source_reflection.options[:polymorphic] && options[:source_type].nil?
      raise StandardError.new(active_record.name, self, source_reflection)
    end

    if macro == :has_one && through_reflection.collection?
      raise StandardError.new(active_record.name, self, through_reflection)
    end

    check_validity_of_inverse!
  end
end
