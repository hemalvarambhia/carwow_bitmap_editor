describe 'Editing a Bitmap' do
  context 'when an exit command is received' do
    class BitmapEditor
      def initialize(input)
        @input = input
      end

      def run
        exit if @input.gets == 'X'
      end
    end

    it 'exits' do
      input = double(:input)
      allow(input).to receive(:gets).and_return 'X'
      editor = BitmapEditor.new input

      expect { editor.run }.to raise_error SystemExit
    end
  end

  context 'when an initialize command is received' do
    it 'continues to run' do
      input = double(:input)
      allow(input).to receive(:gets).and_return 'I 2 2'
      editor = BitmapEditor.new input

      expect { editor.run }.not_to raise_error
    end
  end
end