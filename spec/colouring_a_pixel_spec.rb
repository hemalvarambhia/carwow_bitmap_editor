require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'colouring a pixel' do
    before :each do
      @input = double(:input, print: nil)
      @canvas = double(:canvas, blank: nil)
      @editor = BitmapEditor.new(@input, nil, @canvas)
    end

    it 'colours in the specified pixel' do
      allow(@input).to receive(:gets).and_return 'L 2 3 A'
      expect(@canvas).to receive(:paint).with(column: 1, row: 2, colour: 'A')
      
      @editor.run     
    end

    it 'colours in any pixel' do
      allow(@input).to receive(:gets).and_return 'L 3 4 A'
      expect(@canvas).to receive(:paint).with(column: 2, row: 3, colour: 'A')

      @editor.run
    end

    it 'colours in any pixel with different colours' do
      allow(@input).to receive(:gets).and_return 'L 4 5 B'
      expect(@canvas).to receive(:paint).with(column: 3, row: 4, colour: 'B')

      @editor.run
    end
  end
end
