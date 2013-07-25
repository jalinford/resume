class HeaderTag < ActiveRecord::Base
  attr_accessible :header_id, :tag_id
  belongs_to :header
  belongs_to :tag
end
