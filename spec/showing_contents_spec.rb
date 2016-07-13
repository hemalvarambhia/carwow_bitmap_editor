require 'bitmap_editor'
describe 'Bitmap Editor' do
  context "executing the 'show contents' command" do
    before :each do
      @input = double(:input, print: nil)
      @output = double :output
      @canvas = double(:canvas, blank: nil)
      @editor = BitmapEditor.new(@input, @output, @canvas)
    end

    it 'continues to run' do
      allow(@output).to receive :puts
      allow(@input).to receive(:gets).and_return 'S'

      expect { @editor.run }.not_to raise_error
    end

    context 'when there is no image' do
      it 'displays nothing' do
        allow(@input).to receive(:gets).and_return 'S'
        expect(@output).to receive(:puts).with @canvas

        @editor.run
      end
    end

    it 'displays the contents of any image' do
      allow(@input).to receive(:gets).and_return 'S'
      expect(@output).to receive(:puts).with(@canvas)

      @editor.run
    end
  end
end
