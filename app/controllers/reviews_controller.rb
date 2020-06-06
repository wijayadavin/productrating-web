class ReviewsController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @review = Review.new
    end
  end

  def new
    @review.assign_attributes(review_params)
  end

  def create
    # TODO: Create the record in database
    raise "TODO: Save to database: #{review_params}"
  end

  private
    def review_params
      params.require(:review).permit(:purchase_id)
    end
end
