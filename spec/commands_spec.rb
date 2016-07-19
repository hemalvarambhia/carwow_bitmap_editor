require 'spec_helper'
require 'commands'
require 'canvas'
describe 'Command Factory' do
  include Commands
  before :each do
    canvas = Painting::Canvas.new
    output = double :output
    @commands = setup_for(canvas, output)   
  end

  it 'supports the create canvas command' do
     expect(@commands['I']).to respond_to :run
  end

  it 'supports the clear canvas command' do
    expect(@commands['C']).to respond_to :run
  end

  it 'supports a paint pixel command' do
    expect(@commands['L']).to respond_to :run
  end

  it 'supports a paint vertical line command' do
    expect(@commands['V']).to respond_to :run
  end

  it 'supports a paint horizontal line command' do
    expect(@commands['H']).to respond_to :run
  end

  it 'supports a display canvas command' do
    expect(@commands['S']).to respond_to :run
  end

  it 'supports a help command' do
    expect(@commands['?']).to respond_to :run
  end

  it 'supports a terminate command' do
    expect(@commands['X']).to respond_to :run
  end

  context 'when the command is unsupported' do
    it 'runs a default command' do
      expect(@commands['U']).to respond_to :run
    end
  end
end