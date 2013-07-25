ActiveAdmin.register Header do
  menu :parent => "Resume"
  
  index do                            
    column :title
    column :name
    column :email
    column :phone
    column("Address") do |h|
      (h.address_one + ', ' + h.address_two + ', ' + h.address_three unless h.address_one == '')
    end
    column :default
    default_actions                   
  end  

  form do |f|                         
	f.inputs "Activity Details" do       
	  f.input :title, :hint => "Internal name for this header (ie. default)"                  
	  f.input :name
	  f.input :email
	  f.input :phone
	  f.input :address_one
	  f.input :address_two
	  f.input :address_three
	  f.input :default, :as => :radio, :hint => "Sets this header for all resumes unless otherwise specified"   
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
    end
    active_admin_comments
   end  
end
