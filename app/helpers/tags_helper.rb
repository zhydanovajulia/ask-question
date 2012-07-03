module TagsHelper
	def tags_for_cloud
		tag_array = []
		tags = Tagging.joins('LEFT JOIN tags ON taggings.tag_id = tags.id').
						select('tags.name, COUNT(taggings.tag_id) as count').
						group('taggings.tag_id')
		tags.each do |tag|
			tag_array	<< {text: tag.name, weight: tag.count}
		end
		tag_array
	end
end
