class Store < ApplicationRecord
	has_one_attached :plant_image
	validates :name, :price, :quantity, :plant_image, presence: true
end
