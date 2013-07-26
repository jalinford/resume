class FooterTag < ActiveRecord::Base
  attr_accessible :footer_item_id, :tag_id
  belongs_to :footer_item
  belongs_to :tag
end
