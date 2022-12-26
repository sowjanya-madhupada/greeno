class AddUserToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :cart_id, :integer, :default => nil
  end
end
