class ResumeController < ApplicationController
  def index
  	@tags = Tag.where(featured: true)
  	@all_tags = Tag.all
  end

  def tag
  	@tags = Tag.where(featured: true)
  	@all_tags = Tag.all
  	@tags_displayed = Tag.find_all_by_title(params[:title].split('/'))
  end
end