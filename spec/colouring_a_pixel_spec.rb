require 'spec_helper'
require 'colour_pixel'
require 'coordinates_helper'
describe 'Colouring a pixel on the canvas' do
  include CoordinatesHelper
  before :each do
    @canvas = double(:canvas, blank: nil)
    @colour_pixel = Commands::ColourPixel.new @canvas
  end

  describe 'Correct usage' do
    it 'colours in the specified pixel' do
      point = coordinates(x: 2, y: 3)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'A')

      @colour_pixel.run [2, 3, 'A']
    end

    it 'colours in any pixel' do
      point = coordinates(x: 3, y: 4)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'A')

      @colour_pixel.run [3, 4, 'A']
    end

    it 'colours in any pixel with different colours' do
      point = coordinates(x: 4, y: 5)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'B')

      @colour_pixel.run [4, 5, 'B']
    end
  end
end

