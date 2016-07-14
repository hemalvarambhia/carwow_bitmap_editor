require 'forwardable'
class BitmapEditor
  extend Forwardable

  def initialize(input, commands)
    @input = input
    @commands = commands
  end

  def run
    @input.print '> '
    command = @input.gets.strip

    execute command
  end

  private

  def execute command
    type, *args = command.split ' '

    @commands[type].run args
  end

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
      row = params[:row]
      column = params[:column]
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
  end
end
