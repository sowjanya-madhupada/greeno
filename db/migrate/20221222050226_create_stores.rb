class CreateStores < ActiveRecord::Migration[6.0]
  def change
    drop_table :line_items
    drop_table :stores
    create_table :stores do |t|
      t.string :name
      t.float :price
      t.string :season
      t.string :plants_type
      t.integer :quantity

      t.timestamps
    end
  end
end
