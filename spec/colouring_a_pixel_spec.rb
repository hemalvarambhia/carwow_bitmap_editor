require 'commands'
describe 'Colouring a pixel on the canvas' do
  before :each do
    @canvas = double(:canvas, blank: nil)
    @help = double :help
    @colour_pixel = Commands::ColourPixel.new(@canvas, @help)
  end

  describe 'Correct usage' do
    it 'colours in the specified pixel' do
      expect(@canvas).to receive(:paint).with(column: 2, row: 3, colour: 'A')

      @colour_pixel.run [2, 3, 'A']
    end

    it 'colours in any pixel' do
      expect(@canvas).to receive(:paint).with(column: 3, row: 4, colour: 'A')

      @colour_pixel.run [3, 4, 'A']
    end

    it 'colours in any pixel with different colours' do
      expect(@canvas).to receive(:paint).with(column: 4, row: 5, colour: 'B')

      @colour_pixel.run [4, 5, 'B']
    end

    context 'when extra arguments are given' do
      it 'ignores them' do
        expect(@canvas).to(
          receive(:paint).with(column: 2, row: 10, colour: 'C'))

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

    context 'when the x-coordinate is less than the minimum' do
      it 'demonstrates usage' do
        expect(@help).to receive(:run)
        
        @colour_pixel.run [-2, 3, 'A']
      end
    end

    context 'when the x-coordinate is more than the maximum' do
      it 'demonstrates usage' do
        expect(@help).to receive(:run)
        
        @colour_pixel.run [290, 3, 'A']
      end
    end

    context 'when the y-coordinate is below the minimum' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @colour_pixel.run [10, -3, 'B']
      end
    end

    context 'when the y-coordinate is above the maximum' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @colour_pixel.run [10, 300, 'B']
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

