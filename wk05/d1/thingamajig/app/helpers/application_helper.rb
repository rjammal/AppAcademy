module ApplicationHelper

  def authorize_form
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end
  
  def flash_helper
    flash[:errors] ||= []
    errors = flash[:errors].map { |error| "<li>#{error}</li>" }.join
    "<ul>#{errors}</ul>".html_safe
  end

end
