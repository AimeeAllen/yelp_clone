class Business < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
  has_many :reviews

  def recent_reviews
    reviews.order(created_at: :desc).limit(10)
  end
end
