class TagsController < ApplicationController
	include TagsHelper

	def index
		if params[:question_id].present?
			question = Question.find params[:question_id]
			@question_tags = question.tags.map(&:name)
		end
		@tags = Tag.all.map(&:name)
		@tag_cloud = tags_for_cloud
	end
end
