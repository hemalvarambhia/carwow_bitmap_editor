class BitmapEditor
  attr_reader :image

  def initialize(input, output)
    @input = input
    @output = output
    @image = []
  end

  def run
    command = @input.gets.strip
    type, args = parse command
    initialize_image(
      width: args.first.to_i, height: args.last.to_i) if type == 'I'

    col_index = args.first.to_i - 1
    row_index = args[1].to_i - 1
    color = args.last
    assign_colour(
      row: row_index, column: col_index, colour: color) if type =='L'

    @output.puts image_as_string if type == 'S'

    exit if type == 'X'
  end

  private

  def parse command
    type, *args = command.split ' '

    return type, args
  end

  def initialize_image(dimensions)
    @image = white_image(dimensions[:width], dimensions[:height])
  end

  def white_image(width, height)
    white_rows = Array.new(width) { 'O' }
    white_image = Array.new(height) { white_rows }

    white_image
  end

  def image_as_string
    @image.map { |row| row.join }.join("\n")
  end

  def assign_colour(params)
    row = params[:row]
    column = params[:column]
    colour = params[:colour]
    @image[row][column] = colour
  end
end