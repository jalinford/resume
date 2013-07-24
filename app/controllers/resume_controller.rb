class ResumeController < ApplicationController
  def index
  	@tags = Tag.where(featured: true)
  end

  def tag
  	@tags = Tag.where(featured: true)
  end
end
