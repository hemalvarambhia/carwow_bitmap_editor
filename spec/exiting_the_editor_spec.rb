require 'commands'
describe 'Exiting' do
  before :each do
    @editor = Commands::ExitEditor.new
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


