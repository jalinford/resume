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