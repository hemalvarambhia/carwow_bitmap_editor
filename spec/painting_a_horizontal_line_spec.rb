require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "drawing a horizonal line" do
    before :each do
      @canvas = double(:canvas)
      @draw_horizontal_line = BitmapEditor::DrawHorizontalLine.new(@canvas)
    end
    
    it 'paints only the horizontal line specified' do
      (0..4).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 1, column: column, colour: 'W'))
      end

      @draw_horizontal_line.run  [1, 5, 2, 'W']
    end

    it 'paints a horizontal line anywhere' do
      (0..1).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 2, column: column, colour: 'W'))
      end

      @draw_horizontal_line.run [1, 2, 3, 'W']
    end

    it 'paints a horizontal line anywhere any colour' do
      (0..1).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 2, column: column, colour: 'Z'))
      end

      @draw_horizontal_line.run [1, 2, 3, 'Z']
    end
  end
end
