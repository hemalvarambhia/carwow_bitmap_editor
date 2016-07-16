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
      if ColourPixel.invalid?(args)
        @help.run
      else 
       params = {
          column: args[0].to_i, row: args[1].to_i, colour: args[2]
        }
        @canvas.paint params
      end
    end

    private

    def self.invalid?(args)
      column = args.first.to_i
      row = args[1].to_i
      colour = args[2]
      args.size < 3 or
        !column.between?(1, 250) or !row.between?(1, 250) or
        !('A'..'Z').include?(colour)
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
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      column = args[0].to_i
      if args.size < 4 or column < 1
        @help.run
      else  
        column = args[0].to_i
        colour = args[3]
        from = args[1].to_i
        to = args[2].to_i
        vertical_line(from, to).each do |row|
          paint([column, row, colour])
        end
      end
    end

    private

    def vertical_line(from, to)
      start = [from, to].min
      finish = [from, to].max
      (start..finish)
    end
    
    def paint args
      params = {
        column: args[0].to_i, row: args[1].to_i, colour: args[2]
      }
      @canvas.paint params
    end
  end

  class PaintHorizontalLine
    def initialize canvas
      @canvas = canvas
    end

    def run args
      row = args[2].to_i
      colour = args[3]
      from = args[0].to_i
      to = args[1].to_i
      horizontal_line(from, to).each do |column|
        paint([column, row, colour])
      end
    end

    private

    def horizontal_line(from, to)
      start = [from, to].min
      finish = [from, to].max
      (start..finish)
    end
    
    def paint args
      params = {
        column: args[0].to_i, row: args[1].to_i, colour: args[2]
      }
      @canvas.paint params
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
