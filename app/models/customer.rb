class Customer < ActiveRecord::Base
  validates :cpf_cnpj, :name, presence: true

  scope :active, -> { where active: true }
end
