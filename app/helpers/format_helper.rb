module FormatHelper

  # ==  ✔️TODO: Format the price.
  # 
  def format_price(price)
    # - Display a dollar sign
    # - Display two decimal places
    return "$" + ('%.2f' % price).to_s
  end

end
