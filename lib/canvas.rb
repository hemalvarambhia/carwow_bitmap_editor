module Painting
  class Canvas
    def initialize(pixels = [])
      @pixels = pixels
    end

    def blank(dimensions)
      @dimensions = dimensions
      white_pixels
    end

    def image
      @pixels
    end

    def paint(params)
      row = params[:row] - 1
      column = params[:column] - 1
      return nil if outside_of_canvas?(row, column) 
      colour = params[:colour]
      @pixels[row][column] = colour
    end

    def clear
      white_pixels
    end

    def to_s
      @pixels.map { |row| row.join }.join("\n")
    end

    private

    def white_pixels
      @pixels = Array.new(@dimensions[:height]) do
        Array.new(@dimensions[:width]) { 'O' }
      end
    end

    def outside_of_canvas?(row, column)
      row = @pixels.fetch(row, [])
      column > row.size - 1
    end
  end
end
