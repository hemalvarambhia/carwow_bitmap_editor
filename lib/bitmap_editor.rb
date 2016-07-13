require 'forwardable'
class BitmapEditor
  extend Forwardable
  def_delegator :@bitmap_image, :image
  
  def initialize(input, output)
    @input = input
    @output = output
    @bitmap_image = BitmapImage.new
  end

  def run
    @input.print '> '
    command = @input.gets.strip
    type, args = parse command
    initialise_image(args) if type == 'I'
    paint(args) if type == 'L'
    show_contents if type == 'S'
    vertically_assign_colour(args) if type == 'V'
    if type == 'H'
      (1..5).each do |column|
        paint([column, 2, 'W'])
      end
    end
    clear if type == 'C'
    
    exit if type == 'X'
  end

  private

  def parse command
    type, *args = command.split ' '

    return type, args
  end

  def initialise_image args
    @bitmap_image.blank(
      width: args.first.to_i,
      height: args.last.to_i
    )
  end

  def vertically_assign_colour args
    rows = (args[1]..args[2]).map{|i| i.to_i}
    rows.each do |row|
      column, colour = args.first.to_i, args.last
      paint([column, row, colour])
    end
  end

  def paint args
    params = {
      column: args.first.to_i - 1,
      row: args[1].to_i - 1,
      colour: args.last
    }
    @bitmap_image.paint params
  end

  def show_contents
    @output.puts @bitmap_image.to_s
  end

  def clear
    original_dimensions = {
      height: @bitmap_image.height,
      width: @bitmap_image.width
    }
    @bitmap_image.blank(original_dimensions)
  end

  class BitmapImage
    def initialize(pixels = [])
      @pixels = pixels
    end

    def blank(dimensions)
      @pixels = Array.new(dimensions[:height]) do 
        Array.new(dimensions[:width]) { 'O' } 
      end
    end

    def image
      @pixels
    end

    def width
      @pixels.sample.size
    end

    def height
      @pixels.size
    end

    def paint(params)
      row = params[:row]
      column = params[:column]
      colour = params[:colour]
      @pixels[row][column] = colour
    end

    def to_s
      @pixels.map { |row| row.join }.join("\n")
    end
  end
end
