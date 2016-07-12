require 'bitmap_editor'
describe 'Editing a Bitmap' do
  before :each do
    @input = double :input
    allow(@input).to receive :print
  end

  context "when a 'show contents' command is received" do
    before :each do
      @output = double :output
      @editor = BitmapEditor.new(@input, @output)
    end

    it 'continues to run' do
      allow(@output).to receive :puts
      allow(@input).to receive(:gets).and_return 'S'

      expect { @editor.run }.not_to raise_error
    end

    context 'when there is no image' do
      it 'displays nothing' do
        allow(@input).to receive(:gets).and_return 'S'
      	expect(@output).to receive(:puts).with ""

        @editor.run
      end
    end

    it 'displays the contents of the image' do
      allow(@input).to receive(:gets).and_return 'I 3 2', 'S'
      expect(@output).to receive(:puts).with("OOO\nOOO")

      2.times { @editor.run }
    end 

    it 'displays the contents of any image' do
      allow(@input).to receive(:gets).and_return 'I 4 4', 'S'
      expect(@output).to receive(:puts).with("OOOO\nOOOO\nOOOO\nOOOO")
    
      2.times { @editor.run }
    end
  end

  context "when a 'colour pixel' command is received" do
    before :each do
      @output = double :output
      @editor = BitmapEditor.new(@input, @output)
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
