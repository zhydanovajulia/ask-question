class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_comment, :only => [:edit, :update]
	before_filter :author_require, :only => [:edit]
	before_filter :find_answer, :only => [:new, :create, :update]

	
	def new
		@comment = Comment.new
		respond_to do |format|
			format.js
		end

	end

	def create
		@comment = @answer.comments.create params[:comment].merge!(:user => current_user)
 	   if @comment.save
    	  flash.now[:notice] = "Thanks for your comment"
    	else
      		flash.now[:alert] = "Fill comment body, please"
    	end
	end

	def update
		unless @comment.update_attributes params[:comment]
			flash.now[:alert] = "Comment wasn't save"
		end
	end

	private
	
	def author_require
	  	if current_user != @comment.author
	  		flash.now[:alert] = "Only author of the comment have access to edit"
	  		redirect_to question_path @comment.answer.question
	  	end
	end

  	def find_answer
  		@answer = Answer.find params[:answer_id]
  	end

  	def find_comment
  		@comment = Comment.find params[:id]
  	end
end
