require 'commands'
describe 'Bitmap Editor' do
  describe 'getting help' do
    it 'displays advice on how to use the commands' do
      io_output = double :output
      expect(io_output).to receive(:puts).with Commands::Help::HELP
      help = Commands::Help.new(io_output)

      help.run []
    end
  end
end