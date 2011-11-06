class Route
  include Mongoid::Document
  include Mongoid::Timestamps

  paginates_per 5

  field :name, type: String

  validates :name, :presence => true

  embeds_many :waypoints
  belongs_to :user
  index [[ "waypoints.location", Mongo::GEO2D ]], min: -180, max: 180
end
