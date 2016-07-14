require 'forwardable'
class BitmapEditor
  extend Forwardable
  def_delegator :@canvas, :image
  HELP = "? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session"

  def initialize(input, commands)
    @input = input
    @output = output
    @canvas = canvas
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

  class SetupCanvas
    def initialize(canvas)
      @canvas = canvas
    end

    def run args
      width = args.first.to_i < 1 ? 1 : args.first.to_i
      height = args.last.to_i < 1 ? 1 : args.last.to_i
      width = args.first.to_i > 250 ? 250 : width
      height = args.last.to_i > 250 ? 250 : height
      @canvas.blank(width: width, height: height)    end
  end

  class ColourPixel
    def initialize canvas
      @canvas = canvas
    end

    def run args
      params = {
          column: args.first.to_i - 1,
          row: args[1].to_i - 1,
          colour: args.last
      }
      @canvas.paint params
    end
  end

  class ClearCanvas
    def initialize canvas
      @canvas = canvas
    end

    def run args
      @canvas.clear
    end
  end

  class DrawVerticalLine
    def initialize canvas
      @canvas = canvas
    end

    def run args
      line = (args[1]..args[2]).map{|i| i.to_i}
      line.each do |row|
        column, colour = args.first.to_i, args.last
        paint([column, row, colour])
      end
    end

    private
    def paint args
      params = {
          column: args.first.to_i - 1,
          row: args[1].to_i - 1,
          colour: args.last
      }
      @canvas.paint params
    end
  end

  class DrawHorizontalLine
    def initialize canvas
      @canvas = canvas
    end

    def run args
      line = (args.first..args[1]).map {|column| column.to_i}
      line.each do |column|
        paint([column, args[2].to_i, args.last])
      end
    end

    private
    def paint args
      params = {
          column: args.first.to_i - 1,
          row: args[1].to_i - 1,
          colour: args.last
      }
      @canvas.paint params
    end
  end

  class ExitEditor
    def run args
      exit
    end
  end

  class DisplayImage
    def initialize(output, canvas)
      @output = output
      @canvas = canvas
    end

    def run args
      @output.puts @canvas
    end
  end

  class Help
    HELP = "? - Help
    I M N - Create a new M x N image with all pixels coloured white (O).
    C - Clears the table, setting all pixels to white (O).
    L X Y C - Colours the pixel (X,Y) with colour C.
    V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    S - Show the contents of the current image
    X - Terminate the session"

    def initialize output
      @output = output
    end

    def run args
      @output.puts HELP
    end
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
