require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "drawing a horizonal line" do
    before :each do
      @input = double(:input, print: nil)
      @editor = BitmapEditor.new(@input, nil)
    end
    
    it 'paints only the horizontal line specified' do
      allow(@input).to receive(:gets).and_return 'I 5 3', 'H 1 5 2 W'
      3.times { @editor.run }

      image = @editor.image
      horizontal_segment = image[1][0..-1]
      expect(horizontal_segment).to eq ['W', 'W', 'W', 'W', 'W']
    end

    it 'paints a horizontal line anywhere' do
      allow(@input).to receive(:gets).and_return 'I 5 3', 'H 1 2 3 W'
      3.times { @editor.run }

      image = @editor.image
      horizontal_segment = image[2][0..1]
      expect(horizontal_segment).to eq ['W', 'W']
    end

    it 'paints a horizontal line anywhere any colour' do
      allow(@input).to receive(:gets).and_return 'I 5 3', 'H 1 2 3 Z'

      3.times { @editor.run }

      image = @editor.image
      horizontal_segment = image[2][0..1]
      expect(horizontal_segment).to eq ['Z', 'Z']
    end
  end
end
