require 'bitmap_editor'

describe 'Bitmap Editor' do
  class ClearCanvas
    def initialize canvas
      @canvas = canvas
    end

    def run args
      @canvas.clear
    end
  end

  describe 'clearing the canvas' do
    before :each do
      @canvas = double(:canvas).as_null_object
      @clear_canvas = ClearCanvas.new @canvas
    end

    it 'wipes the canvas clean' do
      expect(@canvas).to receive :clear

      @clear_canvas.run []
    end
  end
end
