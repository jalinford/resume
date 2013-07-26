ActiveAdmin.register Footer, :as => "Skills/Achievements" do
	menu :parent  => "Resume"

  index do                            
	column :title
	column :priority
	column("Items") do |footer|
	  a_array = Array.new
	  footer.footer_items.each do |item|
		a_array.push(item.item)
	  end
	  a_array.join(", ").slice(0, 100)
	end
	default_actions                   
  end     

  form do |f|                         
	f.inputs "Activity Details" do       
	  f.input :title              
	  f.input :priority, :as => :select, :collection => 1..10

		f.has_many :footer_items do |a|
			a.input :item
			a.input :tags, :as => :check_boxes
			a.input :priority, :as => :select, :collection => 1..10
			a.input :_destroy, :as=>:boolean, :required => false, :label=>'Check this box to remove the above Item when Footer updated'
		end


	end                               
	f.actions                         
  end

  show do
	attributes_table do
	  row :title
	  row :priority
    row("Items") do |footer|
	  	a_array = Array.new
	  	footer.footer_items.each do |item|
				a_array.push(item.item)
				a_array.push("(" + item.priority.to_s + ", Tags:")
				item.tags.each do |tag|
					a_array.push(tag.title)
				end
				a_array.push(")")
	  	end
	  	a_array.join(" ").slice(0, 100)
		end
	end
	active_admin_comments
  end

end
