class FooterItem < ActiveRecord::Base
  attr_accessible :footer_id, :item, :priority, :tag_ids
  validates_presence_of :item, :priority
  has_many :footer_tags, :dependent => :destroy
  has_many :tags, :through => :footer_tags
  belongs_to :footer
  accepts_nested_attributes_for :footer
  accepts_nested_attributes_for :tags
  scope :ordered, order("priority DESC")
end
