module ApplicationHelper

  # ==  A helper to get the previous page:
  #    
  def previous_page_helper
    URI(request.referer || '').path
  end

end
