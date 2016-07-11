describe 'Editing a Bitmap' do
  context 'when an exit command is received' do
    class BitmapEditor
      def initialize(input)

      end

      def run
        exit
      end
    end

    it 'exits' do
      input = double(:input)
      allow(input).to receive(:gets).and_return 'X'
      editor = BitmapEditor.new input

      expect { editor.run }.to raise_error SystemExit
    end
  end
end