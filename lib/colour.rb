module Painting
  module Colour
    def unavailable?(colour)
      !('A'..'Z').include?(colour)
    end
  end
end
