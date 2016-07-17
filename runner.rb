require_relative 'lib/bitmap_editor'
require_relative 'lib/commands'
require_relative 'lib/canvas'
std_in = IO.new 0
std_out = IO.new 1

include Commands
canvas = Painting::Canvas.new
commands = Hash.new(Help.new(std_out))
commands['I'] =
  SetupCanvas.new(canvas, Help.new(std_out, SetupCanvas::USAGE))
commands['C'] = ClearCanvas.new(canvas)
commands['S'] = DisplayCanvas.new(std_out, canvas)
commands['L'] =
  ColourPixel.new(canvas, Help.new(std_out, ColourPixel::USAGE))
commands['V'] =
  PaintVerticalLine.new(
    canvas, Help.new(std_out, PaintVerticalLine::USAGE))
commands['H'] =
  PaintHorizontalLine.new(
    canvas, Help.new(std_out, PaintHorizontalLine::USAGE))
commands['X'] = ExitEditor.new
commands['?'] = Help.new(std_out)

editor = BitmapEditor.new(std_in, commands)

loop { editor.run }
