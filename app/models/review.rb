class Review < ActiveRecord::Base
  belongs_to :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
end
