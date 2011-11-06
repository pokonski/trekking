class Waypoint
  include Mongoid::Document
  embedded_in :route

  field :location, :type => Array
  #index [[ :location, Mongo::GEO2D ]], min: -180, max: 180
end