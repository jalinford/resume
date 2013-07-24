module ResumeHelper
	def all_titles
		all_titles_array = []
		@all_tags.each do |tag|
			all_titles_array.push(tag.title)
		end
		all_titles = all_titles_array.sort.join('/')
		return all_titles
	end

	def route_titles(all_tags, tag)
		if all_tags.nil?
			return link_to tag.title, tag_path(:title => tag.title)
		elsif all_tags.include?(tag)
			if all_tags.include?(tag) && all_tags.count == 1
				return link_to tag.title, resume_path
			else
				all_titles_array = []
				all_tags.each do |tag|
					all_titles_array.push(tag.title)
				end
				all_titles_array.delete(tag.title)
				all_titles = all_titles_array.sort.join('/')
				return link_to tag.title, tag_path(:title => all_titles)
			end
		elsif !all_tags.include?(tag)
			all_titles_array = [tag.title]
			all_tags.each do |tag|
				all_titles_array.push(tag.title)
			end
			all_titles = all_titles_array.sort.join('/')
			return link_to tag.title, tag_path(:title => all_titles)
		else
			return link_to tag.title, tag_path(:title => tag.title)
		end
	end

	def all_highlights(highlights, tags)
		all_highlights = []
		highlights.each do |highlight|
			if tags.any? { |tag| tag.activity_highlights.include?(highlight)}
				all_highlights.push(highlight)
			end
		end
		return all_highlights.sort { |a, b| b.priority <=> a.priority }
	end

	def tag_activities(tag)
		activities = []
		tag.activity_highlights.each do |highlight|
			activities.push(highlight.activity)
		end
		return activities.uniq
	end

	def all_tag_activities(tags)
		activities = []
		tags.each do |tag|
			tag_activities(tag).each do |activity|
				activities.push(activity)
			end
		end
		return activities.uniq
	end

	def tag_categories(tag)
		categories = []
		tag_activities(tag).each do |activity|
			categories.push(activity.category)
		end
		return categories.uniq.sort { |a, b| b.priority <=> a.priority }
	end

	def all_tag_categories(tags)
		categories = []
		tags.each do |tag|
			tag_categories(tag).each do |category|
				categories.push(category)
			end
		end
		return categories.uniq.sort { |a, b| b.priority <=> a.priority }
	end
end