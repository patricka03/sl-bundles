class CreateHairs < ActiveRecord::Migration[7.1]
  def change
    create_table :hairs do |t|
      t.string :name
      t.decimal :price
      t.integer :length
      t.string :texture
      t.string :origin
      t.integer :quantity
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
