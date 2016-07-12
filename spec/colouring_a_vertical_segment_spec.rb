require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "executing 'colour vertical segment' command" do
    before :each do
      @input = double :input
      allow(@input).to receive :print
      @output = double(:output).as_null_object
    end

    it 'assigns a colour to a given vertical segment' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'V 2 3 6 W'
      @editor = BitmapEditor.new(@input, @output)

      2.times { @editor.run }

      image = @editor.image
      expect(image[2..5]).to all eq ['O', 'W', 'O', 'O', 'O']
      expect(image[0..1]).to all eq ['O', 'O', 'O', 'O', 'O']
    end

    it 'assigns a colour to any vertical segment' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'V 5 1 3 W'
      @editor = BitmapEditor.new(@input, @output)

      2.times { @editor.run }

      image = @editor.image
      expect(image[0..2]).to all eq ['O', 'O', 'O', 'O', 'W']
      expect(image[3..-1]).to all eq ['O', 'O', 'O', 'O', 'O']
    end
  end
end