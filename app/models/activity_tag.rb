class ActivityTag < ActiveRecord::Base
  attr_accessible :activity_highlight_id, :tag_id
  belongs_to :tag
  belongs_to :activity_highlight
end