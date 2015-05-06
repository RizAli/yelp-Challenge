class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates :name, length: {minimum: 3}, uniqueness: true


  def build_review(user, params)
    review = reviews.build(params)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    # reviews.average(:rating)
    reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
  end


end

