class QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_question, :only => [:show, :edit, :update]
  before_filter :author_require, :only => [:edit]

  def index
    @questions = Question.find(:all, :order => "created_at DESC").paginate(:page => params[:page], :per_page => 4)
  end

  def new
  	@question = Question.new
  end

  def show
    @question.update_attributes(:watch_count => @question.watch_count + 1)
  end

  def create
  	@question = Question.new params[:question].merge!(:user_id => current_user.id)
  	if @question.save
  		redirect_to question_path @question
  		flash[:notice] = "Question was created"
  	else
  		flash[:alert] = "Question wasn't created"
  		render :new
  	end
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
  	if @question.update_attributes params[:question]
  		redirect_to question_path @question
  		flash[:notice] = "Question was updated"
  	else
  		flash[:alert] = "Question wasn't updated"
  		render :edit
  	end
  end

  private

  def find_question
  	@question = Question.find params[:id]
  end

  def author_require
  	if current_user != @question.author
  		flash[:alert] = "Only author of the question have access to edit"
  		redirect_to questions_path
  	end
  end
end
