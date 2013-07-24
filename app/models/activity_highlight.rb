class ActivityHighlight < ActiveRecord::Base
  attr_accessible :activity_id, :category_id, :highlight, :priority, :tag_ids
  validates_presence_of :highlight, :priority
  has_many :activity_tags, :dependent => :destroy
  has_many :tags, :through => :activity_tags
  belongs_to :activity
  accepts_nested_attributes_for :activity, :tags
  scope :ordered, order("priority DESC")
end