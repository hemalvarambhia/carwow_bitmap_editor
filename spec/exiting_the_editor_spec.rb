require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'exiting the editor' do
    before :each do
      @input = double(:input, print: nil)
      @editor = BitmapEditor.new(@input, nil)
    end

    it 'terminates the program' do
      allow(@input).to receive(:gets).and_return 'X'

      expect { @editor.run }.to raise_error SystemExit
    end

    context 'when the command contains a new line' do
      it 'terminates the program' do
        allow(@input).to receive(:gets).and_return "X\n"

        expect { @editor.run }.to raise_error SystemExit
      end
    end
  end
end

