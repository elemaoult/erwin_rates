class ReviewsController < ApplicationController

  # skip_after_action :verify_authorized

  def new
    @user = User.find(params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @user = User.find(params[:user_id])
    @review.user = @user
    if @review.save!
      return "Votre message a bien été enregistré."
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:email, :content)
  end
  
end
