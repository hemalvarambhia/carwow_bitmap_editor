require_relative './coordinates'
require_relative './colour'
module Commands
  class SetupCanvas
    USAGE =
      "I - set up a canvas
       M - width (must be between 1 and 250)
       N - height (must be between 1 and 250)
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if SetupCanvas.invalid?(args)
        @help.run
      else
        @canvas.blank(width: args.first.to_i, height: args[1].to_i)
      end
    end

    private

    def self.invalid? args
      width = args.first.to_i
      height = args[1].to_i
      args.size < 2 or !width.between?(1, 250) or !height.between?(1, 250)
    end
  end

  class ColourPixel
    include Coordinates, Painting::Colour
    USAGE =
      "L - Colour in a pixel
       X - column (must be between 1 and 250)
       Y - row (must be between 1 and 250)
       C - colour (must be between 'A' to 'Z')
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else 
       params = {
          column: args[0].to_i, row: args[1].to_i, colour: args[2]
        }
        @canvas.paint params
      end
    end

    private

    def invalid?(args)
      column, row = args[0].to_i, args[1].to_i
      colour = args[2]
      args.size < 3 or
        !within_bounds?(column, row) or
        unavailable?(colour)
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

  class PaintVerticalLine
    include Coordinates, Painting::Colour
    USAGE =
      "V - paint vertical line
       X - column (must be between 1 and 250)
       Y1 - starting row (must be between 1 and 250)
       Y2 - finishing row (must be between 1 and 250)
       C - colour (must be between 'A' to 'Z')
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else
        column = args[0].to_i
        colour = args[3]
        from, to = args[1].to_i, args[2].to_i
        vertical_line(column, from, to).each do |point|
          params = point.merge(colour: colour)
          paint params
        end
      end
    end

    private

    def invalid?(args)
      column = args[0].to_i
      starting_row = args[1].to_i
      finishing_row = args[2].to_i
      colour = args[3]
      args.size < 4 or
        !within_bounds?(starting_row, column) or
        !within_bounds?(finishing_row, column) or
        unavailable?(colour)
    end

    def vertical_line(column, from, to)
      start = [from, to].min
      finish = [from, to].max
      (start..finish).map { |row| {column: column, row: row} }
    end

    def paint params
      @canvas.paint params
    end
  end

  class PaintHorizontalLine
    include Coordinates, Painting::Colour
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else
        colour = args[3]
        from = args[0].to_i
        to = args[1].to_i
        row = args[2].to_i
        horizontal_line(from, to, row).each do |point|
          params = point.merge(colour: colour)
          @canvas.paint params
        end
      end
    end

    private

    def invalid?(args)
      colour = args[3]
      args.size < 4 or
        !within_bounds?(args[0].to_i, args[2].to_i) or
        !within_bounds?(args[1].to_i, args[2].to_i) or
        unavailable?(colour)
    end

    def horizontal_line(from_column, to_column, row)
      start = [from_column, to_column].min
      finish = [from_column, to_column].max
      (start..finish).map { |column| { row: row, column: column } }
    end
  end

  class ExitEditor
    def run *args
      exit
    end
  end

  class DisplayCanvas
    def initialize(output, canvas)
      @output = output
      @canvas = canvas
    end

    def run *args
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

    def initialize output, text = HELP
      @output = output
      @text = text
    end

    def run *args
      @output.puts @text
    end
  end
end
