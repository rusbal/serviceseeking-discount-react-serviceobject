class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.string :sku, null: false
      t.decimal :price, precision: 5, scale: 2, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
