class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :value
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
