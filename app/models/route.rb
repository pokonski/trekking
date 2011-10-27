class Route < ActiveRecord::Base
  validates :name, :presence => true
  serialize :locations, Array
end
