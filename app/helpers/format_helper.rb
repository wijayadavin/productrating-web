module FormatHelper
  
  def format_price(price)
    # ✔️TODO: Format the price. 
    # - Display a dollar sign
    # - Display two decimal places
    return "$" + ('%.2f' % price).to_s
  end

end
