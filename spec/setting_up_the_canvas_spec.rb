require 'bitmap_editor'
describe 'Bitmap Editor' do
  describe 'setting up the canvas' do
    before :each do
      @input = double(:input, print: nil)
      @canvas = double(:canvas)
      @editor = BitmapEditor.new @input, nil, @canvas
    end

    it 'continues to run the editor' do
      allow(@canvas).to receive(:blank)
      allow(@input).to receive(:gets).and_return 'I 2 2'
      
      expect { @editor.run }.not_to raise_error
    end

    it 'creates a white M x N canvas' do
      allow(@input).to receive(:gets).and_return 'I 2 2'
      expect(@canvas).to receive(:blank).with(width: 2, height: 2)

      @editor.run
    end

    it 'generates a white canvas of any size' do
      allow(@input).to receive(:gets).and_return 'I 3 4'
      expect(@canvas).to receive(:blank).with(width: 3, height: 4)

      @editor.run
    end

    context 'when the dimensions are out of bounds' do
      it 'creates the smallest possible canvas' do
        allow(@input).to receive(:gets).and_return 'I -1 -1'
        expect(@canvas).to receive(:blank).with(width: 1, height: 1)

        @editor.run
      end

      it 'creates the largest possible canvas' do
        allow(@input).to receive(:gets).and_return 'I 300 300'
        expect(@canvas).to receive(:blank).with(width: 250, height: 250)

        @editor.run
      end
    end
  end
end
