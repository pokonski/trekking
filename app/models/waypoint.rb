class Waypoint < ActiveRecord::Base

  acts_as_gmappable

  def position
    "#{latitude} #{longitude}"
  end
end
