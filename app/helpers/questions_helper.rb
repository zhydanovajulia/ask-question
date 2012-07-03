module QuestionsHelper
	def all_tags
		Tag.all.map(&:name)
	end

	def selected_tags question
		question.tags.map(&:name)
	end

	def filtered_questions tag
		Tag.find_by_name(tag).questions
	end
end
