class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.decimal :value
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
