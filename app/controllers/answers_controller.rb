class AnswersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_question, :only => [:create, :update]
	before_filter :find_answer, :only => [:edit, :update]
	before_filter :author_require, :only => [:edit]

	def new
		@question = Question.find params[:question_id]
		@answer = Answer.new
	end

	def create
		@question.update_attributes(:answers_count => @question.answers.count + 1)
		@answer = @question.answers.build params[:answer].merge!(:user_id => current_user.id)
		if @answer.save
			flash[:notice] = "Your answer added successfully"
			redirect_to question_path params[:question_id]
		else
			flash[:alert] = "The answer wasn't created"
			render :new
		end
	end

	def update
		if @answer.update_attributes params[:answer]
			redirect_to question_path @question
  		flash[:notice] = "Answer was updated"
  	else
  		flash[:alert] = "Answer wasn't updated"
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
