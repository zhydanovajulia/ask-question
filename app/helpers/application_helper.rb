module ApplicationHelper
  def j(*args)
    escape_javascript(*args)
  end

	def logged_in_as
		if user_signed_in?
      link_to("Sign out", main_app.destroy_user_session_path, :title => "#{current_user.email} logout", :method => :delete)
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
