require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'getting help' do
    it 'displays advice on how to use the commands' do
      io_output = double :output
      expect(io_output).to receive(:puts).with BitmapEditor::HELP
      help = BitmapEditor::Help.new(io_output)

      help.run []
    end
  end
end