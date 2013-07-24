class ResumeController < ApplicationController
  def index
  	@tags = Tag.where(featured: true)
  end

  def tag
  	@tags = Tag.where(featured: true)
  	@tags_all = Tag.find_all_by_title(params[:title].split('/'))
  end
end
