class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :business
  validates_presence_of :body, :user, :business
end
