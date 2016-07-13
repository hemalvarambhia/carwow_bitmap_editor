require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe "executing the 'colour pixel' command" do
    before :each do
      @input = double(:input, print: nil)
      @editor = BitmapEditor.new(@input, nil)
    end

    context 'when there is no image' do
      it 'does not assign a colour' do
        allow(@input).to receive(:gets).and_return 'L 4 4'

        image = @editor.image
        expect(image).to be_empty
      end
    end

    it 'assigns a pixel the colour specified' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'L 2 3 A'

      2.times { @editor.run }
      
      image = @editor.image
      expect(image[2][1]).to eq 'A'
    end

    it 'assigns any pixel any colour' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'L 4 4 B'

      2.times { @editor.run }

      image = @editor.image
      expect(image[3][3]).to eq 'B'
    end

    it 'leaves all other pixels untouched' do
      allow(@input).to receive(:gets).and_return 'I 2 2', 'L 1 1 B'

      2.times { @editor.run }

      image = @editor.image
      unaffected = [ image[0][1], image[1][0], image[1][1] ]
      expect(unaffected).to all eq 'O'
    end
  end
end
