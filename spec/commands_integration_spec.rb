require 'canvas'
require 'coordinates_helper'
require 'commands'
describe 'Running multiple commands' do
  include CoordinatesHelper
  before :each do
    @canvas = Painting::Canvas.new
  end

  it 'paints on a canvas' do
    Commands::SetupCanvas.new(@canvas, nil).run [3, 3]
    Commands::ColourPixel.new(@canvas, nil).run [3, 3, 'C']
    Commands::PaintVerticalLine.new(@canvas, nil).run [1, 1, 3, 'A']
    Commands::PaintHorizontalLine.new(@canvas, nil).run [2, 3, 1, 'B']

    expect(@canvas).to be_width(3).and be_height(3)
    expect(@canvas).to be_painted('C').at coordinates(x: 3, y: 3)
    [{x: 1, y: 1}, {x: 1, y: 2}, {x: 1, y: 3}].each do |coords|
      expect(@canvas).to be_painted('A').at coordinates(coords)
    end
    [{x: 2, y: 1}, {x: 3, y: 1}].each do |coords|
      expect(@canvas).to be_painted('B').at coordinates(coords)
    end
  end

  RSpec::Matchers.define :be_width do |expected_width|
    match do |canvas|
      image = canvas.image
      image.all? { |row| row.size == expected_width }
    end
  end

  RSpec::Matchers.define :be_height  do |expected_height|
    match do |canvas|
      image = canvas.image
      image.size == expected_height
    end
  end

  RSpec::Matchers.define :be_painted do |colour|
    match do |canvas|
      colour_at_point = canvas.image[@point.y - 1][@point.x - 1]
      colour_at_point == colour
    end

    chain :at do |point|
      @point = point
    end

    failure_message do |actual|
      image = actual.image
      actual_colour = image[@point.y - 1][@point.x - 1]
      message = "Expected colour at (#{@point.x}, #{@point.y}) to "
      message << "be #{colour} but was #{actual_colour}"
      message
    end
  end
end
