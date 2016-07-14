require 'commands'
describe 'Bitmap Editor' do
  describe 'clearing the canvas' do
    before :each do
      @canvas = double(:canvas).as_null_object
      @clear_canvas = Commands::ClearCanvas.new @canvas
    end

    it 'wipes the canvas clean' do
      expect(@canvas).to receive :clear

      @clear_canvas.run []
    end
  end
end
