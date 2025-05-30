class AddTotalToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :total, :decimal, precision: 8, scale: 2, default: 0, null: false
  end
end
