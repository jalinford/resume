class Footer < ActiveRecord::Base
  attr_accessible :priority, :title, :footer_item_ids, :footer_items_attributes
  validates_presence_of :title, :priority
  validates_uniqueness_of :title
  has_many :footer_items, :dependent => :destroy
  accepts_nested_attributes_for :footer_items
  scope :ordered, order("priority DESC")
end
