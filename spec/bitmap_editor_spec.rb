require 'spec_helper'
require 'bitmap_editor'
describe 'Bitmap Editor' do
  before :each do
    @input = double(:input, print: nil)
    @command = double :command
    @commands = { 'C' => @command }
  end

  it "runs any command passed to it" do
    expect(@command).to receive(:run).with ['A1', 'A2']
    allow(@input).to receive(:gets).and_return 'C A1 A2'
    editor = BitmapEditor.new(@input, @commands)

    editor.run
  end

  context 'when a command is invoked in the lower case' do
    it 'handles the corresponding upper-cased command' do
      allow(@input).to receive(:gets).and_return 'c a1 a2'
      expect(@command).to receive(:run).with [ 'A1', 'A2' ]
      editor = BitmapEditor.new(@input, @commands)

      editor.run
    end
  end
end
