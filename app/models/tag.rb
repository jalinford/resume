class Tag < ActiveRecord::Base
  attr_accessible :featured, :objective, :summary, :title, :activity_highlight_ids, :header_ids, :footer_ids
  validates_presence_of :title
  validates_uniqueness_of :title
  has_many :activity_tags, :dependent => :destroy
  has_many :activity_highlights, :through => :activity_tags
  has_many :footer_tags, :dependent => :destroy
  has_many :footer_items, :through => :footer_tags
  has_many :header_tags, :dependent => :destroy
  has_many :headers, :through => :header_tags
  accepts_nested_attributes_for :activity_highlights
  accepts_nested_attributes_for :headers
  accepts_nested_attributes_for :footer_items
  scope :ordered, order("title ASC")
end