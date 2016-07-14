require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'getting help' do
    it 'displays advice on how to use the commands' do
      input = double(:input, print: nil)
      allow(input).to receive(:gets).and_return '?'
      io_output = double :output
      expect(io_output).to receive(:puts).with BitmapEditor::HELP
      editor = BitmapEditor.new(input, io_output, nil)

      editor.run
    end
  end
end