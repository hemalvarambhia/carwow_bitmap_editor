require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "drawing a vertical line" do
    before :each do
      @canvas = double(:canvas)
      @draw_vertical_line = BitmapEditor::DrawVerticalLine.new(@canvas)
    end

    it 'draws a vertical line on the specified part' do
      (2..5).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 1, row: row, colour: 'W'))
      end

      @draw_vertical_line.run [2, 3, 6, 'W']
    end

    it 'draws a vertical line anywhere' do
      (0..2).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 4, row: row, colour: 'W'))
      end

      @draw_vertical_line.run [5, 1, 3, 'W']
    end

    it 'draws a vertical line anywhere in any colour' do
      (1..3).each do |row|
        expect(@canvas).to(
          receive(:paint).with(column: 3, row: row, colour: 'H'))
      end

      @draw_vertical_line.run [4, 2, 4, 'H']
    end
  end
end
