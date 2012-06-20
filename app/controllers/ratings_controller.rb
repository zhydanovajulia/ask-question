class RatingsController < ApplicationController
	include RatingsHelper

	before_filter :find_model, :only => [:create, :destroy]
	def create
		if @model
			unless current_user.rated? @model
				current_user.rate @model, 1	
			else
				flash.now[:alert] = "You can vote only one time"
			end
		end				
		respond_to do |format|
			format.js
		end
	end

	def destroy
		if @model
			current_user.unrate @model
		end
		respond_to do |format|
			format.js
		end
	end

	private
		def find_model
			@model = model_exists params
		end
end
