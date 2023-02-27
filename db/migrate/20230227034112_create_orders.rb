class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :total, precision: 7, scale: 2, null: false
      t.decimal :discount, precision: 5, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
