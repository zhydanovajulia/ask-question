class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :author_require, :only => [:edit]

	private
	
	def author_require
  	if current_user != @question.author
  		flash[:alert] = "Only author of the question have access to edit"
  		redirect_to questions_path
  	end
  end
end
