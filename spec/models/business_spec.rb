require 'spec_helper'

describe Business do
  it {should validate_presence_of(:name)}
  it {should validate_uniqueness_of(:name)}
  it {should have_many(:reviews)}

  describe ".recent_reviews" do
    let(:business) {Fabricate(:business)}
    it "returns an empty array if there are no videos" do
      expect(business.recent_reviews).to eq([])
    end
    it "returns an array of associated videos" do
      reviews = []
      3.times {reviews << Fabricate(:review, business: business)}
      expect(business.recent_reviews).to match_array(reviews)
    end
    it "returns reviews in reverse chronological order" do
      review1 = Fabricate(:review, business: business, created_at: 1.day.ago)
      review2 = Fabricate(:review, business: business)
      expect(business.recent_reviews).to eq([review2, review1])
    end
    it "only returns the top 10 videos" do
      12.times {Fabricate(:review, business: business)}
      expect(business.recent_reviews.count).to eq(10)
    end
  end
end
