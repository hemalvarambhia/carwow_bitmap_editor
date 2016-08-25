require 'spec_helper'
require 'paint_horizontal_line'
require 'coordinates_helper'
describe 'Painting a horizonal line on the canvas' do
  include CoordinatesHelper
  before :each do
    @canvas = double(:canvas)
    @help = double :help
    @draw_horizontal_line =
      Commands::PaintHorizontalLine.new @canvas
  end

  describe 'Correct usage' do
    it 'paints only the horizontal line specified' do
      from, to = coordinates(x: 1, y: 2), coordinates(x: 5, y: 2)
      horizontal_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_horizontal_line.run  [1, 5, 2, 'W']
    end

    it 'paints a horizontal line anywhere' do
      from, to = coordinates(x: 1, y: 3), coordinates(x: 2, y: 3)
      horizontal_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_horizontal_line.run [1, 2, 3, 'W']
    end

    it 'paints a horizontal line anywhere any colour' do
      from, to = coordinates(x: 1, y: 3), coordinates(x: 2, y: 3)
      horizontal_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'Z')
      end

      @draw_horizontal_line.run [1, 2, 3, 'Z']
    end

    it 'paints a horizontal line from right to left' do
      from, to = coordinates(x: 2, y: 3), coordinates(x: 1, y: 3)
      horizontal_line(from, to).each do |point|
        expect(@canvas).to receive(:paint).with(point: point, colour: 'Z')
      end

      @draw_horizontal_line.run [2, 1, 3, 'Z']
    end

    def horizontal_line(from, to)
      start = [from.x, to.x].min
      finish = [from.x, to.x].max

      (start..finish).map { |x_coord| coordinates(x: x_coord, y: from.y) }
    end
  end
end
