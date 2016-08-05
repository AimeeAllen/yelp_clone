class BusinessesController < ApplicationController
  def index
    @businesses = Business.all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(name: params[:business][:name], description: params[:business][:description])
    if @business.save
      flash[:success] = "New business added"
      redirect_to business_path(@business)
    else
      flash[:danger] = "Please fix your input and resubmit"
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new
  end
end
