ActiveAdmin.register Activity do

  index do                            
    column :position
    column :organization
    column :location
    column :category
    column :start_date
    column :end_date
    column("Highlights") do |activity|
      a_array = Array.new
      activity.activity_highlights.each do |highlight|
      	a_array.push(highlight.highlight)
      end
      a_array.join(", ").slice(0, 100)
    end
    default_actions                   
  end     

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
	  		a.input :priority, :as => :select, :collection => 1..10
	  		a.input :_destroy, :as=>:boolean, :required => false, :label=>'Check this box to remove the above Highlight when Activity updated'
	  	end


	end                               
	f.actions                         
  end

  	show :title => :organization do
    attributes_table do
      row :position
      row :organization
      row :category
      row :start_date
      row :end_date
      panel("Highlights") do
      	table_for activity.activity_highlights do |highlight|
    			column :highlight
    			column :priority
    			column("Tags") do |highlight|
      				a_array = Array.new
      				highlight.tags.each do |tag|
      					a_array.push(tag.title)
     				end
     				a_array.join(", ")
     			end
    		end
    	end
    end
    active_admin_comments
   end
   
end