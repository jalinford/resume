class Header < ActiveRecord::Base
  attr_accessible :address_one, :address_three, :address_two, :default, :email, :name, :phone, :title, :tag_ids
  validates_presence_of :title, :name
  validates_uniqueness_of :title
  has_many :header_tags, :dependent => :destroy
  has_many :tags, :through => :header_tags
  accepts_nested_attributes_for :tags
end
