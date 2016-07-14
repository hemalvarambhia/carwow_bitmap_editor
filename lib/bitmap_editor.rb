require 'forwardable'
class BitmapEditor
  extend Forwardable
  def_delegator :@canvas, :image
  
  def initialize(input, output, canvas = Canvas.new)
    @input = input
    @output = output
    @canvas = canvas
  end

  def run
    @input.print '> '
    command = @input.gets.strip

    execute command
  end

  private

  def execute command
    type, *args = command.split ' '

    blank_canvas(args) if type == 'I'
    paint(args) if type == 'L'
    show_contents if type == 'S'
    draw_vertical_line(args) if type == 'V'
    draw_horizontal_line(args) if type == 'H'
    clear if type == 'C'
    exit if type == 'X'
  end

  def blank_canvas args
    width = args.first.to_i < 1 ? 1 : args.first.to_i
    height = args.last.to_i < 1 ? 1 : args.last.to_i 
    width = args.first.to_i > 250 ? 250 : width
    height = args.last.to_i > 250 ? 250 : height
    @canvas.blank(width: width, height: height)
  end

  def draw_vertical_line args
    line = (args[1]..args[2]).map{|i| i.to_i}
    line.each do |row|
      column, colour = args.first.to_i, args.last
      paint([column, row, colour])
    end
  end

  def draw_horizontal_line args
    line = (args.first..args[1]).map {|column| column.to_i}
    line.each do |column|
       paint([column, args[2].to_i, args.last])
    end
  end

  def paint args
    params = {
      column: args.first.to_i - 1,
      row: args[1].to_i - 1,
      colour: args.last
    }
    @canvas.paint params
  end

  def show_contents
    @output.puts @canvas
  end

  def clear
    @canvas.clear
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
