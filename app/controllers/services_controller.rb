class ServicesController < ApplicationController
	include ServicesHelper
	before_filter :authenticate_user!, :except => [:create]

	def index
  	@services = current_user.services.all
	end

	def destroy
  	@service = current_user.services.find(params[:id])
  	@service.destroy
  
  	redirect_to services_path
	end

	def create
  	service = get_service_route params
  	omniauth = request.env['omniauth.auth']

  	if omniauth && params[:service]
  		user_info = get_user_info_from_omniauth omniauth, service
  		unless user_info
  			flash[:error] = 'Error occured while authenticating via ' + service.capitalize + '.'
		    redirect_to new_user_session_path
		    return
		  end

	    if user_info[:uid] && user_info[:provider]
	      unless user_signed_in? && user_signed_in_with_out_system(user_info)
	        check_if_user_registered user_info
	      else
	        check_if_service_linked_to_user user_info
	      end  
	    else
	      flash[:error] =  service.capitalize + ' returned invalid data for the user id.'
	      redirect_to new_user_session_path
	    end
	  else
	    flash[:error] = 'Error occured while authenticating via ' + service.capitalize + '.'
	    redirect_to new_user_session_path
	  end

	end
end
