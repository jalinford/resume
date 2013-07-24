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