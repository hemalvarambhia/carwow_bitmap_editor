module Coordinates
  class Point
    attr_reader :x, :y
    
    def initialize(coords)
      @x = coords[:x]
      @y = coords[:y]
    end

    def within_bounds?
      @x.between?(1, 250) and @y.between?(1, 250)
    end
  end
end
