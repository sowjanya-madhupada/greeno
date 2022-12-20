class CreateStores < ActiveRecord::Migration[6.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.float :price
      t.string :season
      t.string :plants_type

      t.timestamps
    end
  end
end
