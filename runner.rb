require_relative 'lib/bitmap_editor'
require_relative 'lib/commands'
std_in = IO.new 0
std_out = IO.new 1

include Commands
canvas = BitmapEditor::Canvas.new
commands = {
    'I' => SetupCanvas.new(canvas),
    'C' => ClearCanvas.new(canvas),
    'S' => DisplayImage.new(std_out, canvas),
    'L' => ColourPixel.new(canvas),
    'V' => DrawVerticalLine.new(canvas),
    'H' => DrawHorizontalLine.new(canvas),
    'X' => ExitEditor.new,
    '?' => Help.new(std_out)
}

editor = BitmapEditor.new(std_in, commands)

loop { editor.run }
