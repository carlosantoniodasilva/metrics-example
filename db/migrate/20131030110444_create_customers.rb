class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :cpf_cnpj, limit: 14
      t.string :name
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
