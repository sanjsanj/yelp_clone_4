class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  def create_review review_params
    self.reviews.create review_params
  end
end
