require 'coordinates'

module CoordinatesHelper
  def coordinates coords
    Coordinates::Point.new coords
  end
end