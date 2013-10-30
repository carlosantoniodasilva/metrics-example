class Customer < ActiveRecord::Base
  validates :cpf_cnpj, :name, presence: true
end
