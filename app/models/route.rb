class Route
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validates :name, :presence => true

  embeds_many :waypoints

end
