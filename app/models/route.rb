class Route < ActiveRecord::Base
  validates :name, :presence => true
  has_many :waypoints
end
