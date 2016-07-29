class User < ActiveRecord::Base
  validates_presence_of :username, :password
  validates_uniqueness_of :username
  has_secure_password validations: false
  has_many :reviews

  def recent_reviews
    reviews.order(created_at: :desc).limit(10)
  end
end
