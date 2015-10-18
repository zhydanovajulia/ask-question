module ApplicationHelper
  def j(*args)
    escape_javascript(*args)
  end

	def logged_in_as
		if user_signed_in?
      content_tag(:div, current_user.email, class: "navbar-text")
    end
	end

  def log_out
    if user_signed_in?
      link_to("Sign out", main_app.destroy_user_session_path, :method => :delete)
    end
  end

	def flash_messages(css_class)
    flash.map do |key, value|
      mess = value.is_a?(Array) ? value.join('<br />') : value
      mess += "<span class='close'></span>".html_safe
      content_tag(:div, mess.html_safe, :class => "flash_#{key} #{css_class}")
    end.join
  end
end
