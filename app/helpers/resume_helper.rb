module ResumeHelper
	def all_titles
		all_titles_array = []
		@all_tags.each do |tag|
			all_titles_array.push(tag.title)
		end
		all_titles = all_titles_array.sort.join('/')
		return all_titles
	end
end