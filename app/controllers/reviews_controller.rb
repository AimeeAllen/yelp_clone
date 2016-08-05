class ReviewsController < ApplicationController
  def create
    @business = Business.find(params[:business_id])
    @review = Review.new(business: @business, user: current_user, body: params[:review][:body])
    if @review.save
      flash[:success] = "Thank you for your review on #{@business.name}" 
      redirect_to business_path(@business)
    else
      flash[:danger] = "Please type a review before hitting Submit"
      render "businesses/show"
    end
  end
end
