class AddUserToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :user_id, :integer, :default => nil
    add_column :carts, :purchased_at, :date
  end
end
