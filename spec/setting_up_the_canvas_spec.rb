require 'commands'
describe 'Bitmap Editor' do
  describe 'setting up the canvas' do
    before :each do
      @canvas = double(:canvas)
      @set_up_canvas = Commands::SetupCanvas.new @canvas
    end

    it 'creates a white M x N canvas' do
      expect(@canvas).to receive(:blank).with(width: 2, height: 2)

      @set_up_canvas.run [2, 2]
    end

    it 'generates a white canvas of any size' do
      expect(@canvas).to receive(:blank).with(width: 3, height: 4)

      @set_up_canvas.run [3, 4]
    end

    context 'when the dimensions are out of bounds' do
      it 'creates the smallest possible canvas' do
        expect(@canvas).to receive(:blank).with(width: 1, height: 1)

        @set_up_canvas.run [-1, -1]
      end

      it 'creates the largest possible canvas' do
        expect(@canvas).to receive(:blank).with(width: 250, height: 250)

        @set_up_canvas.run [300, 300]
      end
    end
  end
end
