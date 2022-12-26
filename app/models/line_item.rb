class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :store

  def total_price
    self.quantity * store.price
  end
end
