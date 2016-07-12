require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "executing 'colour vertical segment' command" do
    it 'assigns a colour to a given vertical segment' do
      input = double :input
      allow(input).to receive :print
      io_output = double(:output).as_null_object
      allow(input).to receive(:gets).and_return 'I 5 6', 'V 2 3 6 W'
      @editor = BitmapEditor.new(input, io_output)

      2.times { @editor.run }

      image = @editor.image
      expect(image[2..5]).to all eq ['O', 'W', 'O', 'O', 'O']
      expect(image[0..1]).to all eq ['O', 'O', 'O', 'O', 'O']
    end
  end
end