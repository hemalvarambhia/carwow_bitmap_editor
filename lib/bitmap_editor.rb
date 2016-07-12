class BitmapEditor
  attr_reader :image

  def initialize(input, output)
    @input = input
    @output = output
    @bitmap_image = BitmapImage.new(width: 0, height: 0)
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

  def image
    @bitmap_image.image
  end

  private

  def parse command
    type, *args = command.split ' '

    return type, args
  end

  def initialize_image(dimensions)
    @bitmap_image = BitmapImage.new dimensions
  end

  def image_as_string
    @bitmap_image.to_s
  end

  def assign_colour(params)
    @bitmap_image.assign_colour params
  end

  class BitmapImage
    attr_reader :image

    def initialize(dimensions)
      @image = white_image(dimensions[:width], dimensions[:height])
    end

    def assign_colour(params)
      row = params[:row]
      column = params[:column]
      colour = params[:colour]
      @image[row][column] = colour
    end

    def to_s
      @image.map { |row| row.join }.join("\n")
    end

    def white_image(width, height)
      white_rows = Array.new(width) { 'O' }
      white_image = Array.new(height) { white_rows }

      white_image
    end
  end
end