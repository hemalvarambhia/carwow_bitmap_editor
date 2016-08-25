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
        'I' => SetupCanvas.new(canvas),
        'C' => ClearCanvas.new(canvas),
        'S' => DisplayCanvas.new(output, canvas),
        'L' => ColourPixel.new(canvas),
        'V' =>
            PaintVerticalLine.new(canvas),
        'H' =>
            PaintHorizontalLine.new(canvas),
        'X' => ExitEditor.new,
        '?' => Help.new(output)
    }
    commands.default = Help.new(output)

    commands
  end
end
