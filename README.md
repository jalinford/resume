This has been built from Foundation 4 and ActiveAdmin to provide a dynamic resume.

The (unproofread) steps at the beginning included:

$ rails new resume

$ cd resume

in Gemfile (after rails gem)

gem 'activeadmin'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation'
end

gem "jquery-rails", "2.3.0"

group :development do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
end

group :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
end

group :production do
  gem 'pg'
end

bundle install
 (to install the gems)

rails g foundation:install

git init

git add .

git commit -m 'First Commit'

rails generate controller main index

rails g controller resume index tag

delete rails welcome file (index) in public

In Routes:
root :to => 'main#index'
match 'resume', :to => "resume#index"

rails g active_admin:install
rake db:migrate

Make sure root is first in Gemfile

Check active admin at /admin
Check title in /config/initializers/active_admin.rb (config.site_title)

Partial for App Layouts - _header
In layouts: 

<header><%= render 'layouts/header' %></header>

<nav class="top-bar">
  <ul class="title-area">
    <li class="name">
      <h1><%= link_to "Example Resume", root_path %></h1>
    </li>
    <li class="toggle-topbar menu-icon"><a href="#"><span>Menu</span></a></li>
  </ul>
  <section class="top-bar-section">
    <ul class="right">
      <li class="divider"></li>
      <li><%= link_to "Home", root_path %></li>
      <li class="divider"></li>
      <li><%= link_to "Resume", resume_path %></li>
    </ul>
  </section>
</nav>

Check that program functions with rails s, debug as needed


git add .
git commit -m 'Second Commit'

rails generate model Tag title:string objective:text summary:text featured:boolean
rails generate model Activity category_id:integer position:string organization:string location:string start_date:date end_date:date priority:integer
rails generate model ActivityHighlight activity_id:integer highlight:string priority:integer
rails generate model ActivityTag activity_highlight_id:integer tag_id:integer
rails generate model Category title:string priority:integer

edit model associations to be:

class Activity < ActiveRecord::Base
attr_accessible :end_date, :location, :organization, :position, :priority, :start_date, :activity_highlight_ids, :activity_highlights_attributes, :category_id
  validates_presence_of :organization
  has_many :activity_highlights, :dependent => :destroy
  belongs_to :category
  accepts_nested_attributes_for :activity_highlights, :category
  scope :ordered, order("priority DESC")
end

class ActivityHighlight < ActiveRecord::Base
  attr_accessible :activity_id, :category_id, :highlight, :priority, :tag_ids
  validates_presence_of :highlight, :priority
  has_many :activity_tags, :dependent => :destroy
  has_many :tags, :through => :activity_tags
  belongs_to :activity
  accepts_nested_attributes_for :activity, :tags
  scope :ordered, order("priority DESC")
end

class ActivityTag < ActiveRecord::Base
  attr_accessible :activity_highlight_id, :tag_id
  belongs_to :tag
  belongs_to :activity_highlight
end

class Tag < ActiveRecord::Base
  attr_accessible :featured, :objective, :summary, :title, :activity_highlight_ids
  validates_presence_of :title
  validates_uniqueness_of :title
  has_many :activity_tags, :dependent => :destroy
  has_many :activity_highlights, :through => :activity_tags
  accepts_nested_attributes_for :activity_highlights
  scope :ordered, order("title ASC")
end

class Category<ActiveRecord::Base
  attr_accessible :priority, :title, :activity_ids
  validates_presence_of :title
  has_many :activities
  accepts_nested_attributes_for :activities
  scope :ordered, order("priority DESC")
end

rake db:migrate

Check that program functions with rails s, debug as needed

rails g active_admin:resource activity
rails g active_admin:resource tag
rails g active_admin:resource category

Check that program functions with rails s, debug as needed (for activeadmin go to /admin, sign in as admin@example.com password)

git add .
git commit -m 'Third commit'

Changed in /admin for:

ActiveAdmin.register Activity do
  menu :parent => "Resume"

  form do |f|                         
	f.inputs "Activity Details" do       
	  f.input :position              
	  f.input :organization
	  f.input :location        
	  f.input :start_date
	  f.input :end_date
	  f.input :category, :as => :radio

	  	f.has_many :activity_highlights do |a|
	  		a.input :highlight
	  		a.input :tags, :as => :check_boxes
	  		a.input :priority, :hint => "A number between 1 and 10"
	  		a.input :_destroy, :as=>:boolean, :required => false, :label=>'Check this box to remove the above Highlight when Activity updated'
	  	end


	end                               
	f.actions                         
  end
end

ActiveAdmin.register Tag do
  menu :parent => "Resume"

  form do |f|                         
	f.inputs "Activity Details" do       
	  f.input :title, :hint => "Name of a type of Resume"                  
	  f.input :featured, :as => :radio
	  f.input :objective
	  f.input :summary        
	  end                               
	f.actions                         
  end
end

ActiveAdmin.register Category do
  menu :parent => "Resume"

  form do |f|                         
	f.inputs "Category Details" do       
	  f.input :title, :hint => "Title of section of the resume"                  
	  f.input :priority, :hint => "A number between 1 and 10"
	  end                               
	f.actions                         
  end
end


In all controller pages add:
@tags = Tag.where(featured: true)

In view/resume/index add:
<ul><% @tags.each do |tag| %>
	<li><%= tag.title %> </li>
<% end %></ul>

Test if if viewed correctly (add into activeadmin: admin@example.com, password)

git add .
git commit -m 'ActivAdmin forms'

In routes, add: 
get '/resume/*title', :to => "resume#tag", as: 'tag'

In contollers/resume_controller add:
@tags_all = Tag.find_all_by_title(params[:title].split('/'))

Check resume/(your tag with capitalization) to see if it displays

in header partial, change the link_to resume  to:
      <li class="has-dropdown"><a href="#">Resume</a>
        <ul class="dropdown">
          <li><%= link_to "General Information", resume_path %></li>
          <li><label>Featured Resumes</label></li>
          <% @tags.each do |tag| %>
            <li><%= link_to tag.title, tag_path(:title => tag.title) %></li>
          <% end %>
        </ul>
      </li>
    </ul>

git add .
git commit -m 'Dynamic NavBar'

At top of both view/resume for index and tag add:
<%= render 'sub_nav' %>

In new _sub_nav.html.erb partial add:
<dl class="sub-nav">
  <dt>Resume Filter:</dt>
  <dd class="<%= 'active' if @tags_displayed.nil? %>" ><%= link_to "None", resume_path %></dd>
  <% @all_tags.each do |tag| %>
		<dd class="<%= 'active' unless @tags_displayed.nil? || !@tags_displayed.include?(tag) %>"><%= link_to tag.title, tag_path(:title => tag.title) %></dd>
	<% end %>
	<dd class="<%= 'active' if !@tags_displayed.nil? && @tags_displayed.sort == @all_tags.sort %>" ><%= link_to "All", tag_path(:title => all_titles) %></dd>
</dl>

In resume_helper add:
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

And in resume controller make sure to have: 

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

Check look of sub_nav in resume views! No data yet … but it is all set up and ready!

git add .
git commit -m 'Sub-nav basic added'

Time to display the data:


For Activity/AcivityHighlight
validates :priority, :numerically => { :greater_than => 0, less_than_or_equal_to => 10 }

check!

Edit views to display information simply (use first resume)

Edit navbar to have multiple options for resume (if featured)

Edit in sub_nav bar (use first resume)

For creating header:

When redo, has tag_idSSS

class Header < ActiveRecord::Base
  attr_accessible :address_one, :address_three, :address_two, :default, :email, :name, :phone, :tag_id, :title
  validates_presence_of :title, :name, :email
  validates_uniqueness_of :title
  belongs_to :tag
  accepts_nested_attributes_for :tag
  scope :ordered, order("priority DESC")
end

ActiveAdmin.register Header do
  menu :parent => "Resume"
  index do                            
    column :title
    column :name
    column :email
    column :phone
    column("Address") do |header|
      a_array = Array.new
      a_array.push(header.address_one)
      a_array.push(header.address_two) unless header.address_two == ''
      a_array.push(header.address_three) unless header.address_three == ''
      a_array.join(", ")
    end
    column :priority
    default_actions                   
  end  

  form do |f|                         
	f.inputs "Category Details" do       
	  f.input :title, :hint => "Title of section of the resume"                  
	  f.input :name, :hint => "Your name"
	  f.input :email
	  f.input :phone
	  f.input :address_one
	  f.input :address_two
	  f.input :address_three
	  f.input :priority, :as => :select, :collection => 1..10, :hint => "Higher numbers will appear first"
	  f.input :default, :as => :radio, :hint => "If you want to make this the default header for all resumes unless otherwise specified"
	  end                               
	f.actions                         
  end

  show do
    attributes_table do
      row :title
      row :name
      row :email
      row :phone
      row :address_one
      row :address_two
      row :address_three
      row :default
      row :priority
    end
    active_admin_comments
   end
end

rails generate model Header title:string name:string email:string phone:string address_one:string address_two:string address_three:string default:boolean
rails generate model HeaderTag header_id:integer tag_id:integer

add belongs_to tag
add stuff in tag model, especially belongs to

move to active_admin: 
rails g active_admin:resource header
rake db:migrate

For creating skills and Achievements (known in this as a footer):

rails generate model Footer title:string priority:integer
rails generate model FooterItem footer_id:integer item:string priority:integer
rails generate model FooterTag footer_item_id:integer tag_id:integer

move to active_admin: 
rails g active_admin:resource footer
rake db:migrate