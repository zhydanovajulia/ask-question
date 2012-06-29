class TagsController < ApplicationController
	def index
		question = Question.find params[:question_id]
		@tags = Tag.all.map(&:name)
		@question_tags = question.tags.map(&:name)
	end
end
