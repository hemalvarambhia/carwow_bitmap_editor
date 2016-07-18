require_relative '../lib/setup_canvas'
require_relative '../lib/clear_canvas'
require_relative '../lib/colour_pixel'
require_relative '../lib/paint_vertical_line'
require_relative '../lib/paint_horizontal_line'
require_relative '../lib/display_canvas'
require_relative '../lib/help'
require_relative '../lib/exit_editor'

module Commands
  def setup_for(canvas, std_out)
    commands = {
        'I' => SetupCanvas.new(canvas, Help.new(std_out, SetupCanvas::USAGE)),
        'C' => ClearCanvas.new(canvas),
        'S' => DisplayCanvas.new(std_out, canvas),
        'L' => ColourPixel.new(canvas, Help.new(std_out, ColourPixel::USAGE)),
        'V' =>
            PaintVerticalLine.new(
                canvas, Help.new(std_out, PaintVerticalLine::USAGE)),
        'H' =>
            PaintHorizontalLine.new(
                canvas, Help.new(std_out, PaintHorizontalLine::USAGE)),
        'X' => ExitEditor.new,
        '?' => Help.new(std_out)
    }
    commands.default = Help.new(std_out)

    commands
  end
end
