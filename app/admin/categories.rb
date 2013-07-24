ActiveAdmin.register Category do
  menu :parent => "Resume"
  index do                            
    column :title
    column :priority
    default_actions                   
  end  

  form do |f|                         
	f.inputs "Category Details" do       
	  f.input :title, :hint => "Title of section of the resume"                  
	  f.input :priority, :hint => "A number between 1 and 10"
	  end                               
	f.actions                         
  end

  show do
    attributes_table do
      row :title
      row :priority
    end
    active_admin_comments
   end
end