class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer, index: true
      t.boolean :completed, default: false
      t.text :comments

      t.timestamps
    end
  end
end
