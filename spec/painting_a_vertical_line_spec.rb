require 'spec_helper'
require 'paint_vertical_line'
require 'coordinates_helper'
describe 'Painting a vertical line on the canvas' do
  include CoordinatesHelper
  before :each do
    @canvas = double(:canvas)
    @draw_vertical_line =
      Commands::PaintVerticalLine.new @canvas
  end

  describe 'Correct usage' do
    it 'paints a vertical line on the specified part' do
      from, to = coordinates(x: 2, y: 3), coordinates(x: 2, y: 6)
      vertical_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_vertical_line.run [2, 3, 6, 'W']
    end

    it 'paints a vertical line anywhere' do
      from, to = coordinates(x: 5, y: 1), coordinates(x: 5, y: 3)
      vertical_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_vertical_line.run [5, 1, 3, 'W']
    end

    it 'paints a vertical line anywhere in any colour' do
      from, to = coordinates(x: 4, y: 2), coordinates(x: 4, y: 4)
      vertical_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'H')
      end

      @draw_vertical_line.run [4, 2, 4, 'H']
    end

    it 'paints a vertical line in an upward direction' do
      from, to = coordinates(x: 4, y: 4), coordinates(x: 4, y: 2)
      vertical_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'H')
      end

      @draw_vertical_line.run [4, 4, 2, 'H']
    end

    def vertical_line(from, to)
      start = [from.y, to.y].min
      finish = [from.y, to.y].max

      (start..finish).map {|y_coord| coordinates(x: from.x, y: y_coord) }
    end
  end
end
