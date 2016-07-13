require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "drawing a vertical line" do
    before :each do
      @input = double(:input, print: nil)
      @canvas = double(:canvas).as_null_object
      @editor = BitmapEditor.new(@input, nil, @canvas)
    end

    it 'draws a vertical line on the specified part' do
      allow(@input).to receive(:gets).and_return 'V 2 3 6 W'
      (2..5).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 1, row: row, colour: 'W'))
      end

      @editor.run
    end

    it 'draws a vertical line anywhere' do
      allow(@input).to receive(:gets).and_return 'V 5 1 3 W'
      (0..2).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 4, row: row, colour: 'W'))
      end

      @editor.run
    end

    it 'draws a vertical line anywhere in any colour' do
      allow(@input).to receive(:gets).and_return 'V 4 2 4 H'
      (1..3).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 3, row: row, colour: 'H'))
      end

      @editor.run
    end
  end
end
