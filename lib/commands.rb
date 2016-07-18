require_relative '../lib/setup_canvas'
require_relative '../lib/clear_canvas'
require_relative '../lib/colour_pixel'
require_relative '../lib/paint_vertical_line'
require_relative '../lib/paint_horizontal_line'
require_relative '../lib/display_canvas'
require_relative '../lib/help'
require_relative '../lib/exit_editor'

module Commands
  def setup_for(canvas, output)
    commands = {
        'I' => SetupCanvas.new(canvas, Help.new(output, SetupCanvas::USAGE)),
        'C' => ClearCanvas.new(canvas),
        'S' => DisplayCanvas.new(output, canvas),
        'L' => ColourPixel.new(canvas, Help.new(output, ColourPixel::USAGE)),
        'V' =>
            PaintVerticalLine.new(
                canvas, Help.new(output, PaintVerticalLine::USAGE)),
        'H' =>
            PaintHorizontalLine.new(
                canvas, Help.new(output, PaintHorizontalLine::USAGE)),
        'X' => ExitEditor.new,
        '?' => Help.new(output)
    }
    commands.default = Help.new(output)

    commands
  end
end
