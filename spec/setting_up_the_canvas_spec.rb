require 'spec_helper'
require 'setup_canvas'
describe 'Setting up the canvas' do
  before :each do
    @canvas = double(:canvas)
    @set_up_canvas = Commands::SetupCanvas.new @canvas
  end

  describe 'Correct usage' do
    it 'creates a white M x N canvas' do
      expect(@canvas).to receive(:blank).with(width: 2, height: 2)

      @set_up_canvas.run [2, 2]
    end

    it 'generates a white canvas of any size' do
      expect(@canvas).to receive(:blank).with(width: 3, height: 4)

      @set_up_canvas.run [3, 4]
    end
  end
end

