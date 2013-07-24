ActiveAdmin.register Tag do
  menu :parent => "Resume"
  
  index do                            
    column :title
    column :featured
    column :objective.slice(0, 150)
    column :summary.slice(0, 150)
    default_actions                   
  end  

  form do |f|                         
	f.inputs "Activity Details" do       
	  f.input :title, :hint => "Name of a type of Resume"                  
	  f.input :featured, :as => :radio
	  f.input :objective
	  f.input :summary        
	  end                               
	f.actions                         
  end

  show do
    attributes_table do
      row :title
      row :featured
      row :objective
      row :summary
    end
    active_admin_comments
   end
end