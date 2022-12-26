class User < ApplicationRecord
  has_one :cart
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true, length: { maximum: 100 }
  validates :phone_number, presence: true, numericality: true, length: { minimum: 7, maximum: 15 }
end
