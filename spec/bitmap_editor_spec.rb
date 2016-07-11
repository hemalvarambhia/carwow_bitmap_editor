describe 'Editing a Bitmap' do
  context 'when an exit command is received' do
    class BitmapEditor
      attr_reader :image
      def initialize(input)
        @input = input
      end

      def run
        @image = [['0','0'], ['0', '0']]
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
    before :each do
      @input = double :input
      @editor = BitmapEditor.new @input
    end

    it 'continues to run' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      expect { @editor.run }.not_to raise_error
    end

    it 'generates a white M x N image' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      @editor.run

      image = @editor.image
      expect(@editor.image).to be_white_image(2, 2)
    end

    RSpec::Matchers.define :be_white_image do |width, height|
      match do |image|
        white = '0' 
        columns = Array.new(width) { white }
     	expected_image = Array.new(height) { columns }
        image == expected_image
      end

      failure_message do |actual|
        message = "Expected a #{width} x #{height} white image but got:\n"
        message << "#{actual.sample.size} x #{actual.size} white image"
        message
      end
    end
  end
end