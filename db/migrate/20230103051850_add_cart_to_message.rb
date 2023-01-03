class AddCartToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :conversations, :cart_id, :integer, :default => nil
  end
end
