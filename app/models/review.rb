class Review < ActiveRecord::Base
  belongs_to :user
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this restaurant already" }
  belongs_to :restaurant
  validates :rating, inclusion: (1..5)
  has_many :endorsements
end
