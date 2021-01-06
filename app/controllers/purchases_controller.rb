class PurchasesController < ApplicationController
  before_action do
    @product = Product.find(params[:product_id])

    case action_name.to_sym
    when :new, :create
      @purchase = @product.purchases.new
    when :show, :destroy
      @purchase = @product.purchases.find(params[:id])
    end
  end

  def new
  end

  def create
    # TODO: Also decrease product quantity.
    # - For example, if `purchase.quantity` is 3, decrease `product.quantity` by 3
    # - Display an error if `product.quantity` is less than 0 (negative number)
    @purchase.assign_attributes(purchase_params)
    
    # === UPDATE QUANTITY AFTER PURCHASE ===
    # Get product quantity (before purchase):
    @product_quantity_before = Product.find(params[:product_id])["quantity"].to_i
    @product_quantity_after = @product_quantity_before - purchase_params["quantity"].to_i

    if @product_quantity_after < 0
      flash[:error] = 'Sorry, the purchase was failed due to product is currently Out of stock.'
      redirect_to product_url(@product)
    end

    # If quantity after purchase is greater than 0, update `product.quantity`:
    if @purchase.save
      puts "saving..."
      puts @product_quantity_after
      @product.update_attributes({"quantity" => (@product_quantity_after)}) 
      redirect_to product_url(@product)

    else
      flash[:error] = @purchase.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    # TODO: Show edit form
  end

  def update
    # TODO: Update record (save to database)
  end

  def destroy
    # TODO: Delete record
      if @purchase.destroy
        redirect_to product_url(@product)
      else
        flash[:error] = @purchase.errors.full_messages.join(', ')
        render :new
      end
  end

  def show
  end

  private
    def purchase_params
      params.require(:purchase).permit(:quantity, :delivery_address)
    end
end  
