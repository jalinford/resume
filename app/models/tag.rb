class Tag < ActiveRecord::Base
  attr_accessible :featured, :objective, :summary, :title, :activity_highlight_ids
  validates_presence_of :title
  validates_uniqueness_of :title
  has_many :activity_tags, :dependent => :destroy
  has_many :activity_highlights, :through => :activity_tags
  accepts_nested_attributes_for :activity_highlights
  scope :ordered, order("title ASC")
end