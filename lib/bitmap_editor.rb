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
    type, args = parse command
    blank_canvas(args) if type == 'I'
    paint(args) if type == 'L'
    show_contents if type == 'S'
    draw_vertical_line(args) if type == 'V'
    if type == 'H'
      (args.first..args[1]).map {|column| column.to_i}.each do |column|
        paint([column, args[2].to_i, args.last])
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

  def blank_canvas args
    @canvas.blank(width: args.first.to_i, height: args.last.to_i)
  end

  def draw_vertical_line args
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
    @canvas.paint params
  end

  def show_contents
    @output.puts @canvas
  end

  def clear
    original_dimensions = {
      height: @canvas.height,
      width: @canvas.width
    }
    @canvas.blank(original_dimensions)
  end

  class Canvas
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
