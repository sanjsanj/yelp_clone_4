class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, uniqueness: true

  def create_review review_params
    self.reviews.create review_params
  end
end
