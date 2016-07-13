require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "executing a 'colour horizontal segment' command" do
    it 'colours only the horizontal segment specified' do
      input = double(:input, print: nil)
      allow(input).to receive(:gets).and_return 'I 5 3', 'H 1 5 2 W'
      editor = BitmapEditor.new(input, nil)
      3.times { editor.run }

      image = editor.image
      horizontal_segment = image[1][0..-1]
      expect(horizontal_segment).to eq ['W', 'W', 'W', 'W', 'W']
    end
  end
end
