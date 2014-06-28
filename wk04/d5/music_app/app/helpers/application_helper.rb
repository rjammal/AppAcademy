module ApplicationHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def flash_helper
    flash[:errors] ||= []
    html = "<ul>"
    flash[:errors].each do |error|
        html += "<li>#{h(error)}</li>"
    end
    html += "</ul>"
    html.html_safe
  end

  def authorize_form
    "<input 
        type='hidden'
        name='authenticity_token'
        value='#{ form_authenticity_token }'>".html_safe
  end

  def edit_method
    "<input
        type='hidden'
        name='_method'
        value='PATCH'>".html_safe
  end

end
