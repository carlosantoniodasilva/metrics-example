class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than: 0, allow_blank: true }

  scope :active, -> { where active: true }
end
