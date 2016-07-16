require_relative 'lib/bitmap_editor'
require_relative 'lib/commands'
require_relative 'lib/canvas'
std_in = IO.new 0
std_out = IO.new 1

include Commands
canvas = Painting::Canvas.new
commands = Hash.new(Help.new(std_out))
commands['I'] = SetupCanvas.new(canvas)
commands['C'] = ClearCanvas.new(canvas)
commands['S'] = DisplayCanvas.new(std_out, canvas)
commands['L'] = ColourPixel.new(canvas)
commands['V'] = PaintVerticalLine.new(canvas)
commands['H'] = PaintHorizontalLine.new(canvas)
commands['X'] = ExitEditor.new
commands['?'] = Help.new(std_out)

editor = BitmapEditor.new(std_in, commands)

loop { editor.run }
