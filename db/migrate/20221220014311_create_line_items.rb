class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.references :cart, foreign_key: true
      t.references :store, foreign_key: true
      t.integer :quantity,:default=>1

      t.timestamps
    end
  end
end
