module ServicesHelper
	def get_service_route params
  	params[:service] ? params[:service] : 'no service (invalid callback)'
  end

  def get_user_info_from_omniauth omniauth, service
  	user_info = {}
  	if service == 'facebook'
	   	user_info[:email] = omniauth['extra']['raw_info']['email'] ? omniauth['extra']['raw_info']['email'] : nil
	   	user_info[:name] = omniauth['extra']['raw_info']['name'] ? omniauth['extra']['raw_info']['name'] : nil
	   	user_info[:uid] = omniauth['extra']['raw_info']['id'] ? omniauth['extra']['raw_info']['id'] : nil
	   	user_info[:provider] = omniauth['provider'] ? omniauth['provider'] : nil
	   	user_info
		else
		 	nil
		end
  end

  def user_signed_in_with_out_system user_info
  	return nil unless auth = Service.find_by_provider_and_uid(user_info[:provider], user_info[:uid])
    flash[:notice] = 'Signed in successfully via ' + user_info[:provider].capitalize + '.'
    sign_in_and_redirect(:user, auth.user)
  end

  def check_if_user_registered user_info
    unless user_info[:email] == ''
	    existing_user = User.find_by_email(user_info[:email])
	    if existing_user
        existing_user.services.create(:provider => user_info[:provider], :uid => user_info[:uid], :uname => existing_user.name, :uemail => existing_user.email)
        flash[:notice] = 'Sign in via ' + user_info[:provider].capitalize + ' has been added to your account ' + existing_user.email + '. Signed in successfully!'
        sign_in_and_redirect(:user, existing_user)
      else
        new_user = User.new :email => user_info[:email], :password => SecureRandom.hex(10), :name => user_info[:name]
        new_user.services.build(:provider => user_info[:provider], :uid => user_info[:uid], :uname => user_info[:name], :uemail => user_info[:email])
        new_user.save!
        flash[:notice] = 'Your account on Ask Question has been created via ' + user_info[:provider].capitalize
        sign_in_and_redirect(:user, new_user)
      end
    else
      flash[:error] =  service_route.capitalize + ' can not be used to sign-up on Ask Question as no valid email address has been provided.'
	    redirect_to new_user_session_path
    end
  end

  def check_if_service_linked_to_user user_info
	  unless Service.find_by_provider_and_uid(user_info[:provider], user_info[:uid])
	    current_user.services.create(:provider => user_info[:provider], :uid => user_info[:uid], :uname => user_info[:name], :uemail => email)
	    flash[:notice] = 'Sign in via ' + user_info[:provider].capitalize + ' has been added to your account.'
	    redirect_to services_path
	  else
	    flash[:notice] = service_route.capitalize + ' is already linked to your account.'
	    redirect_to services_path
	  end  
  end
end
