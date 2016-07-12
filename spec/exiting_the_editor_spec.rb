require 'bitmap_editor'
describe 'Bitmap Editor' do
  before :each do
    @input = double :input
    allow(@input).to receive :print
  end

  describe 'executing the exit command' do
    before :each do
      @output = double(:output).as_null_object
      @editor = BitmapEditor.new(@input, @output)
    end

    it 'exits' do
      allow(@input).to receive(:gets).and_return 'X'

      expect { @editor.run }.to raise_error SystemExit
    end

    context 'when the exit command contains a new line' do
      it 'exits' do
        allow(@input).to receive(:gets).and_return "X\n"

        expect { @editor.run }.to raise_error SystemExit
      end
    end
  end
end

