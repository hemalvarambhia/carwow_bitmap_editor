require_relative 'lib/bitmap_editor'
require_relative 'lib/commands'
require_relative 'lib/canvas'
std_in = IO.new 0
std_out = IO.new 1

include Commands
canvas = Painting::Canvas.new
commands = setup_for(canvas, std_out)
editor = BitmapEditor.new(std_in, commands)

loop { editor.run }
