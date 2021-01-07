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


  def create
    # ✔️TODO: Also decrease product quantity.
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)
    @purchase.assign_attributes(purchase_params)

    # Get product quantity (before purchase):
    @product_quantity_before = Product.find(params[:product_id])["quantity"].to_i
    @product_quantity_after = @product_quantity_before - purchase_params["quantity"].to_i

    if @product_quantity_after < 0
      flash[:error] = '⚠️There is not enough stock for this product.⚠️'
      return redirect_to product_url(params[:product_id])
    end

    # If quantity after purchase is greater than 0, update `product.quantity`:
    if @purchase.save
      @product.update_attributes({"quantity" => (@product_quantity_after)}) 
      return redirect_to product_url(params[:product_id])

    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end


  def edit
    # ✔️TODO: Show edit form
  end


  def update
    # ✔️TODO: Update record (save to database)
    @new_record = params[:purchase]

    # remove duplicated:
    @new_record.each do |key, value|
      if  @new_record[key].to_s == @purchase[key].to_s
        @new_record.delete(key)
      end
    end

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


  def destroy
    # ✔️TODO: Delete record
      if @purchase.destroy
        redirect_to product_url(params["product_id"])
      else
        flash[:error] = @purchase.errors.full_messages.join(', ')
      end
  end

  def show
    @review = Review.where(purchase_id: params[:id]).take
  end


  private
    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end  
