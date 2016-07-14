require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'colouring a pixel' do
    before :each do
      @canvas = double(:canvas, blank: nil)
      @editor = BitmapEditor::ColourPixel.new(@canvas)
    end

    it 'colours in the specified pixel' do
      expect(@canvas).to receive(:paint).with(column: 1, row: 2, colour: 'A')
      
      @editor.run [2, 3, 'A']
    end

    it 'colours in any pixel' do
      expect(@canvas).to receive(:paint).with(column: 2, row: 3, colour: 'A')

      @editor.run [3, 4, 'A']
    end

    it 'colours in any pixel with different colours' do
      expect(@canvas).to receive(:paint).with(column: 3, row: 4, colour: 'B')

      @editor.run [4, 5, 'B']
    end
  end
end
