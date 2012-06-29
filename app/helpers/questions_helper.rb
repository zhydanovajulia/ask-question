module QuestionsHelper
	def all_tags
		Tag.all.map(&:name)
	end

	def selected_tags
		@question.tags.map(&:name)
	end
end
