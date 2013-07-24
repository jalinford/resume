class MainController < ApplicationController
  def index
  	@tags = Tag.where(featured: true)
  end
end
