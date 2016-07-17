module Painting
  module Colour
    def unsupported?(colour)
      !('A'..'Z').include?(colour)
    end

    def unavailable?(colour)
      !('A'..'Z').include?(colour)
    end
  end
end
