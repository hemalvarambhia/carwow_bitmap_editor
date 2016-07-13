require 'bitmap_editor'

describe 'Bitmap Editor' do
  describe 'clearing the canvas' do
    before :each do
      @input = double(:input, print: nil)
      @canvas = double(:canvas).as_null_object
    end

    context 'when there is no image' do
      it 'does nothing' do
        allow(@input).to receive(:gets).and_return 'C'
        expect(@canvas).to receive(:blank)
        editor = BitmapEditor.new(@input, nil, @canvas)
        
        editor.run
      end
    end

    it 'wipes the canvas clean' do
      allow(@input).to receive(:gets).and_return 'C'
      expect(@canvas).to receive :blank
      editor = BitmapEditor.new(@input, nil, @canvas)

      editor.run
    end
  end
end
