class CommentsController < ApplicationController
	before_filter :authenticate_user!
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
      flash[:notice] = "Thanks for your comment"
    else
      flash[:alert] = "Fill comment body, please"
    end
	end

	private
	
	def author_require
  	if current_user != @question.author
  		flash[:alert] = "Only author of the question have access to edit"
  		redirect_to questions_path
  	end
  end

  def find_answer
  	@answer = Answer.find params[:answer_id]
  end
end
