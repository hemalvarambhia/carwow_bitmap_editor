require 'canvas'
require 'coordinates_helper'
require 'commands'
require 'canvas_matchers'
describe 'Running multiple commands' do
  include CoordinatesHelper, CanvasMatchers
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
end
