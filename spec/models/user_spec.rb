require 'spec_helper'

describe User do
  it {should validate_presence_of(:username)}
  it {should validate_uniqueness_of(:username)}
  it {should validate_presence_of(:password)}
  it {should have_secure_password}
  it {should have_many(:reviews)}

  describe ".recent_reviews" do
    let(:user) {Fabricate(:user)}
    it "returns an empty array if there are no videos" do
      expect(user.recent_reviews).to eq([])
    end
    it "returns an array of associated videos" do
      reviews = []
      3.times {reviews << Fabricate(:review, user: user)}
      expect(user.recent_reviews).to match_array(reviews)
    end
    it "returns reviews in reverse chronological order" do
      review1 = Fabricate(:review, user: user, created_at: 1.day.ago)
      review2 = Fabricate(:review, user: user)
      expect(user.recent_reviews).to eq([review2, review1])
    end
    it "only returns the top 10 videos" do
      12.times {Fabricate(:review, user: user)}
      expect(user.recent_reviews.count).to eq(10)
    end
  end
end
