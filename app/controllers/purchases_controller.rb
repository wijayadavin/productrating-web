class PurchasesController < ApplicationController
  before_action do
    @product = Product.find(params[:product_id])
    case action_name.to_sym
    when :new, :create
      @purchase = @product.purchases.new
    when :show, :destroy, :update, :edit
      @purchase = @product.purchases.find(params[:id])
    end
  end


  def new
  end

  # ==  ✔️TODO: Also decrease product quantity
  # 
  def create
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)
    @purchase.assign_attributes(purchase_params)

    # Get product quantity (before & after):
    @product_quantity_before = Product.find(params[:product_id])["quantity"].to_i
    @product_quantity_after = @product_quantity_before - purchase_params["quantity"].to_i

    # If 'after' quantity is validated, send error:
    if @product_quantity_after < 0
      flash[:error] = '⚠️There is not enough stock for this product.⚠️'
      return redirect_to product_url(params[:product_id])
    # else if the new record updated successfully saved, redirect, else send error:
    elsif @purchase.save
      @product.update_attributes({"quantity" => (@product_quantity_after)}) 
      return redirect_to product_url(params[:product_id])
    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end


  # ==  ✔️TODO: Show edit form
  # 
  def edit
    # (no need extra params)
  end


  # ==  ✔️TODO: Update record (save to database)
  # 
  def update
    # get params:
    @new_record = params[:purchase]

    # remove existing value in purchase param:
    @new_record.each do |key, value|
      if  @new_record[key].to_s == @purchase[key].to_s
        @new_record.delete(key)
      end
    end

    # if empty, send error, else update existing value:
    if @new_record.empty?
      flash[:error] = '⚠️ Nothing changed ⚠️'
      redirect_to product_purchase_url()
    else
      if @purchase.update({
        "quantity" => @new_record["quantity"].to_i,
        "delivery_address" => @new_record["delivery_address"].to_s
        })
        redirect_to product_purchase_url()
      else
        flash[:error] = @purchase.errors.full_messages.join(', ')
      end
    end
  end


  # == ✔️TODO: Delete record
  # 
  def destroy
      # redirect if successfully deleted, else send error: 
      if @purchase.destroy
        redirect_to product_url(params["product_id"])
      else
        flash[:error] = @purchase.errors.full_messages.join(', ')
      end
  end


  def show
    # forward review data to the review#show:
    @review = Review.where(purchase_id: params[:id]).take
  end


  private
    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end  
