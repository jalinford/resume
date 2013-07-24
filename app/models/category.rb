class Category<ActiveRecord::Base
  attr_accessible :priority, :title, :activity_ids
  validates_presence_of :title
  has_many :activities
  accepts_nested_attributes_for :activities
  scope :ordered, order("priority DESC")
end