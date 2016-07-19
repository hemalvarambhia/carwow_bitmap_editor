require 'spec_helper'
require 'canvas'
require 'coordinates_helper'
require 'canvas_matchers'
describe 'A Canvas' do
  include CoordinatesHelper, CanvasMatchers
  before :each do
    @canvas = Painting::Canvas.new
  end

  describe '#blank' do
    it 'creates a blank canvas with the specified dimensions' do
      image = @canvas.blank(width: 3 ,height: 3)

      expect(@canvas).to be_width(3).and be_height(3).and be_white
    end

    it 'creates a blank canvas of any specified dimensions' do
      @canvas.blank(width: 5 ,height: 4)

      expect(@canvas).to be_width(5).and be_height(4).and be_white
    end
  end

  describe '#to_s' do
    it 'renders the pixels as a string' do
      @canvas.blank(width: 4, height: 2)

      expect(@canvas.to_s).to eq "OOOO\nOOOO"
    end

    it 'renders any set of pixels as a string' do
      @canvas.blank(width: 3, height: 3)

      expect(@canvas.to_s).to eq "OOO\nOOO\nOOO"
    end
  end

  describe '#paint' do
    before :each do
      @canvas.blank(width: 2, height: 2)
    end

    it 'paints the given pixel a colour' do
      point = coordinates(x: 1, y: 1)
      @canvas.paint(point: point, colour: 'H')

      expect(@canvas).to be_painted('H').at point
    end

    it 'paints any pixel a colour' do
      point = coordinates(x: 2, y: 1) 
      @canvas.paint(point: point, colour: 'H')  

      expect(@canvas).to be_painted('H').at point
    end

    it 'paints any pixel any colour' do
      point = coordinates(x: 1, y: 2)
      @canvas.paint(point: point, colour: 'X')       

      expect(@canvas).to be_painted('X').at point
    end

    it 'leaves all other pixels white' do
      point = coordinates(x: 1, y: 2)
      @canvas.paint(point: point, colour: 'X')

      [
        coordinates(x: 1, y: 1), 
        coordinates(x: 2, y: 1),
        coordinates(x: 2, y: 2),
      ].each do |point|
        expect(@canvas).to be_painted('O').at point
      end
    end

    it 'does not paint outside of the defined boundaries' do
      not_on_canvas = coordinates(x: 3, y: 1)
      colour = @canvas.paint(point: not_on_canvas, colour: 'U')

      expect(@canvas).to be_width(2).and be_height(2)
      expect(colour).to be_nil
    end

    it 'does not paint away from the canvas' do
      not_on_canvas = coordinates(x: 3, y: 3)
      colour = @canvas.paint(point: not_on_canvas, colour: 'U')

      expect(@canvas).to be_width(2).and be_height(2)
      expect(colour).to be_nil
    end
  end

  describe '#clear' do
    it 'clears the canvas' do
      @canvas.blank(width: 2, height: 2)
      
      @canvas.paint(
        point: coordinates(x: 1, y: 1), colour: 'A')
      @canvas.paint(
        point: coordinates(x: 2, y: 2), colour: 'B')
      @canvas.clear

      expect(@canvas).to be_width(2).and be_height(2).and be_white
    end

    it 'clears a canvas with no image' do
      @canvas.clear

      expect(@canvas).to be_width(0).and be_height(0)
    end
  end

  RSpec::Matchers.define :be_white do
    match do |canvas|
      image = canvas.image
      white = Array.new(image.sample.size) {'O'}
      image.all? { |row| row == white }
    end
  end
end
