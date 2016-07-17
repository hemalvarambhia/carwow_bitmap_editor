require 'commands'
describe 'Painting a vertical line on the canvas' do
  before :each do
    @canvas = double(:canvas)
    @help = double :help
    @draw_vertical_line =
      Commands::PaintVerticalLine.new(@canvas, @help)
  end

  describe 'Correct usage' do
    it 'paints a vertical line on the specified part' do
      (3..6).each do |y_coord|
        point = Coordinates::Point.new(x: 2, y: y_coord)
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_vertical_line.run [2, 3, 6, 'W']
    end

    it 'paints a vertical line anywhere' do
      (1..3).each do |y_coord|
        point = Coordinates::Point.new(x: 5, y: y_coord)
        expect(@canvas).to receive(:paint).with(point: point, colour: 'W')
      end

      @draw_vertical_line.run [5, 1, 3, 'W']
    end

    it 'paints a vertical line anywhere in any colour' do
      (2..4).each do |y_coord|
        point = Coordinates::Point.new(x: 4, y: y_coord)
        expect(@canvas).to receive(:paint).with(point: point, colour: 'H')
      end

      @draw_vertical_line.run [4, 2, 4, 'H']
    end

    it 'paints a vertical line in an upward direction' do
      (2..4).each do |y_coord|
        point = Coordinates::Point.new(x: 4, y: y_coord)
        expect(@canvas).to receive(:paint).with(point: point, colour: 'H')
      end

      @draw_vertical_line.run [4, 4, 2, 'H']
    end

    context 'when it receives extra parameters' do
      it 'ignores them' do
        (2..3).each do |y_coord|
          point = Coordinates::Point.new(x: 1, y: y_coord)
          expect(@canvas).to receive(:paint).with(point: point, colour: 'H')
        end

        @draw_vertical_line.run [1, 2, 3, 'H', 'N']
      end
    end
  end

  describe 'Incorrect usage' do
    before :each do
      allow(@canvas).to receive :paint
    end
    
    context 'when it receives too few arguments' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @draw_vertical_line.run [1, 2, 3]
      end
    end

    context 'when the starting coordinate is out of bounds' do
      it 'demonstrates usage' do
        [[1, -1, 3, 'Z'], [1, 1, 251, 'A']].each do |invalid_coords|
          expect(@help).to receive :run
        
          @draw_vertical_line.run [1, -1, 3, 'Z']
        end
      end
    end

    context 'when the ending coordinate is out of bounds' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @draw_vertical_line.run [1, 2, 0, 'W']
      end
    end

    context 'when the colour is outside the acceptable range' do
      it 'demonstrates usage' do
        ['@', 'EF' 'FGH' '123' 'D1E2', nil ].each do |colour| 
          expect(@help).to receive :run
          
          @draw_vertical_line.run [ 1, 2, 4, colour ]
        end
      end
    end
  end
end
