require 'forwardable'
class BitmapEditor
  extend Forwardable

  def initialize(input, commands)
    @input = input
    @commands = commands
  end

  def run
    @input.print '> '
    command = @input.gets.strip.upcase

    execute command
  end

  private

  def execute command
    type, *args = command.split ' '

    @commands[type].run args
  end
end
