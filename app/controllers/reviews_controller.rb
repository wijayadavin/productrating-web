class ReviewsController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @review = Review.new    
    end
  end


  def new
  end


  def create
    # ✔️TODO: Create the record in database
    @review.assign_attributes(review_params)
    @purchase = Purchase.find(params["review"][:purchase_id])

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
