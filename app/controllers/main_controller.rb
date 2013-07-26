class MainController < ApplicationController
  def index
  	@tags = Tag.where(featured: true).order("title ASC")
  end
end
