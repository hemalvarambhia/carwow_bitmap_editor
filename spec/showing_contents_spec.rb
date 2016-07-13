require 'bitmap_editor'
describe 'Bitmap Editor' do
  context "executing the 'show contents' command" do
    before :each do
      @input = double(:input, print: nil)
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
end
