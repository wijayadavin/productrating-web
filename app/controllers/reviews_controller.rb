class ReviewsController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @review = Review.new    
      @purchase = Purchase.find(params["review"][:purchase_id])
    end
  end


  def new
  end


  # == ✔️TODO: Create the record in database
  # 
  def create
    #  assign the review param:
    @review.assign_attributes(review_params)

    #  if successfully saved, redirect, else send error:
    if @review.save
      redirect_to product_purchase_url(@purchase["product_id"], @purchase["id"])
    else
      flash[:error] = @review.errors.full_messages.join(', ')
      redirect_to product_purchase_url(@purchase["product_id"], @purchase["id"])
    end
  end


  private
    def review_params
      params.require(:review).permit(:purchase_id, :rating, :comment, :product_id)
    end
end
