require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "drawing a horizonal line" do
    before :each do
      @input = double(:input, print: nil)
      @canvas = double(:canvas)
      @editor = BitmapEditor.new(@input, nil, @canvas)
    end
    
    it 'paints only the horizontal line specified' do
      allow(@input).to receive(:gets).and_return 'H 1 5 2 W'
      (0..4).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 1, column: column, colour: 'W'))
      end

      @editor.run
    end

    it 'paints a horizontal line anywhere' do
      allow(@input).to receive(:gets).and_return 'H 1 2 3 W'
      (0..1).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 2, column: column, colour: 'W'))
      end

      @editor.run
    end

    it 'paints a horizontal line anywhere any colour' do
      allow(@input).to receive(:gets).and_return 'H 1 2 3 Z'
      (0..1).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 2, column: column, colour: 'Z'))
      end

      @editor.run
    end
  end
end
