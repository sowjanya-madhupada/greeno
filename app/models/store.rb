class Store < ApplicationRecord
	has_one_attached :plant_image
	validates :name, :price, :quantity, presence: true
	validates :price, :quantity, numericality: {other_than: 0}
end
