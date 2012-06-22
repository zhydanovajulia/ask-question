class AnswersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_question, :only => [:create, :update, :edit]
	before_filter :find_answer, :only => [:edit, :update]
	before_filter :author_require, :only => [:edit]

	def new
		@question = Question.find params[:question_id]
		@answer = Answer.new
	end

	def create
		@answer = @question.answers.create params[:answer].merge!(:user_id => current_user.id)
	end

	def update
		if @answer.update_attributes params[:answer]
			flash.now[:notice] = "Answer successfully created"
			redirect_to question_path @answer.question
		else
			flash.now[:alert] = "Body can't be blank"
			render :edit
		end
	end

	private

	def find_question
		@question = Question.find params[:question_id]
	end

	def find_answer
		@answer = Answer.find params[:id]
	end

  def author_require
  	if current_user != @answer.author
  		flash[:alert] = "Only author of the question have access to edit"
  		redirect_to question_path @question
  	end
  end
end
