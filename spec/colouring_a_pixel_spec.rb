require 'commands'
require 'coordinates'
describe 'Colouring a pixel on the canvas' do
  include Coordinates
  before :each do
    @canvas = double(:canvas, blank: nil)
    @help = double :help
    @colour_pixel = Commands::ColourPixel.new(@canvas, @help)
  end

  describe 'Correct usage' do
    it 'colours in the specified pixel' do
      point = Coordinates::Point.new(x: 2, y: 3)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'A')

      @colour_pixel.run [2, 3, 'A']
    end

    it 'colours in any pixel' do
      point = Coordinates::Point.new(x: 3, y: 4)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'A')

      @colour_pixel.run [3, 4, 'A']
    end

    it 'colours in any pixel with different colours' do
      point = Coordinates::Point.new(x: 4, y: 5)
      expect(@canvas).to receive(:paint).with(point: point, colour: 'B')

      @colour_pixel.run [4, 5, 'B']
    end

    context 'when extra arguments are given' do
      it 'ignores them' do
        point = Coordinates::Point.new(x: 2, y: 10)
        expect(@canvas).to(
          receive(:paint).with(point: point, colour: 'C'))

        @colour_pixel.run [2, 10, 'C', 'B']
      end
    end
  end

  describe 'Incorrect usage' do
    before :each do
      allow(@canvas).to receive :paint
    end
    
    context 'when all arguments are not given' do
      it 'demonstrates usage' do
        expect(@help).to receive(:run)
        
        @colour_pixel.run [2]
      end
    end

    context 'when the coordinate is out of bounds' do
      it 'demonstrates usage' do
        [ [251, 3, 'A'], [3, 251, 'A'] ].each do |invalid_coords|
          expect(@help).to receive(:run)
        
          @colour_pixel.run invalid_coords
        end
      end
    end

    context 'when the colour is outside the acceptable range' do
      it 'demonstrates usage' do
        ['@', 'EF' 'FGH' '123' 'D1E2', nil ].each do |colour| 
          expect(@help).to receive :run
          @colour_pixel.run [10, 10, colour]
        end
      end
    end
  end
end

