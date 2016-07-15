require 'commands'
describe 'Colouring a pixel on the canvas' do
  before :each do
    @canvas = double(:canvas, blank: nil)
    @colour_pixel = Commands::ColourPixel.new(@canvas)
  end

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
      expect(@canvas).to receive(:paint).with(column: 2, row: 10, colour: 'C')

      @colour_pixel.run [2, 10, 'C', 'B']
    end
  end
end

