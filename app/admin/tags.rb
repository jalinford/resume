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