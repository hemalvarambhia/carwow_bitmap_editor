module Commands
  class SetupCanvas
    def initialize(canvas)
      @canvas = canvas
    end

    def run args
      width = args.first.to_i < 1 ? 1 : args.first.to_i
      height = args[1].to_i < 1 ? 1 : args[1].to_i
      width = args.first.to_i > 250 ? 250 : width
      height = args[1].to_i > 250 ? 250 : height
      @canvas.blank(width: width, height: height)
    end
  end

  class ColourPixel
    def initialize canvas
      @canvas = canvas
    end

    def run args
      params = {
          column: args.first.to_i,
          row: args[1].to_i,
          colour: args[2]
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
      column = args[0].to_i
      colour = args[3]
      from = args[1].to_i
      to = args[2].to_i
      vertical_line(from, to).each do |row|
        paint([column, row, colour])
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
          column: args.first.to_i,
          row: args[1].to_i,
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
          column: args.first.to_i,
          row: args[1].to_i,
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

  class DisplayCanvas
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
end
