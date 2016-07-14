require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'exiting the editor' do
    before :each do
      @editor = BitmapEditor::ExitEditor.new
    end

    it 'terminates the program' do
      expect { @editor.run [] }.to raise_error SystemExit
    end

    context 'when the command contains a new line' do
      it 'terminates the program' do
        expect { @editor.run [] }.to raise_error SystemExit
      end
    end
  end
end

