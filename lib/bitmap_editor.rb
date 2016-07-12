require 'forwardable'
class BitmapEditor
  extend Forwardable
  def_delegator :@bitmap_image, :image
  
  def initialize(input, output)
    @input = input
    @output = output
    @bitmap_image = BitmapImage.white(width: 0, height: 0)
  end

  def run
    @input.print '> '
    command = @input.gets.strip
    type, args = parse command
    initialise_image(args) if type == 'I'
    assign_colour(args) if type == 'L'
    show_contents if type == 'S'
    vertically_assign_colour(args) if type == 'V' 

    exit if type == 'X'
  end

  private

  def parse command
    type, *args = command.split ' '

    return type, args
  end

  def initialise_image args
    @bitmap_image = BitmapImage.white(
       width: args.first.to_i, height: args.last.to_i)
  end

  def vertically_assign_colour args
    rows = (args[1]..args[2]).map{|i| i.to_i}
    rows.each do |row|
      column, colour = args.first.to_i, args.last
      assign_colour([column, row, colour])
    end
  end

  def assign_colour args
    col_index = args[0].to_i - 1
    row_index = args[1].to_i - 1
    color = args[2]
    @bitmap_image.assign_colour(
      row: row_index, column: col_index, colour: color)
  end

  def show_contents
    @output.puts @bitmap_image.to_s
  end

  class BitmapImage
    attr_reader :image

    def BitmapImage.white(dimensions)
      pixels = Array.new(dimensions[:height]) do 
        Array.new(dimensions[:width]) { 'O' } 
      end
      new pixels
    end
    
    def initialize(pixels)
      @image = pixels ||
               BitmapImage.white_image(dimensions[:width], dimensions[:height])
    end

    def assign_colour(params)
      row = params[:row]
      column = params[:column]
      colour = params[:colour]
      @image[row][column] = colour
    end

    def to_s
      @image.map { |row| row.join }.join("\n")
    end
  end
end
