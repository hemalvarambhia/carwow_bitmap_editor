require 'forwardable'
class BitmapEditor
  extend Forwardable
  def_delegator :@bitmap_image, :image
  
  def initialize(input, output)
    @input = input
    @output = output
    @bitmap_image = BitmapImage.new(width: 0, height: 0)
  end

  def run
    command = @input.gets.strip
    type, args = parse command
    initialise_image args if type == 'I'
    assign_colour args if type == 'L'
    show_contents if type == 'S'
    exit if type == 'X'
  end

  private

  def parse command
    type, *args = command.split ' '

    return type, args
  end

  def initialise_image args
    @bitmap_image = BitmapImage.new(
       width: args.first.to_i, height: args.last.to_i)
  end

  def assign_colour args
    col_index = args.first.to_i - 1
    row_index = args[1].to_i - 1
    color = args.last
    @bitmap_image.assign_colour(
      row: row_index, column: col_index, colour: color)
  end

  def show_contents
    @output.puts @bitmap_image.to_s
  end

  class BitmapImage
    attr_reader :image

    def initialize(dimensions)
      @image = BitmapImage.white(dimensions[:width], dimensions[:height])
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

    private

    def BitmapImage.white(width, height)
      white_rows = Array.new(width) { 'O' }
      white_image = Array.new(height) { white_rows }

      white_image
    end
  end
end