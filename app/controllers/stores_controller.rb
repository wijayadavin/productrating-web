
# ==  ✔️TODO: Implement 
# 
class StoresController < ApplicationController
  before_action do
    case action_name.to_sym
    when :new, :create
      @store = Store.new
    when :show, :edit, :update, :destroy
      @store = Store.find(params[:id])
    end
  end


  def new
  end


  def create
    # assign record:
    @store.assign_attributes(store_params)

    #  redirect if successfully saved, else send error:
    if @store.save
      redirect_to stores_url()
    else
      flash[:error] = @store.errors.full_messages.join(', ')
      render :new
    end
  end


  def show
    #  forward product record to product#show:
    @products = Product.where({id: params[:id]})
  end


  def index
    #  forward all store records to product#index:
    @stores = Store.all
  end


  private
    def store_params
      params.require(:store).permit(:name, :city)
    end
end
