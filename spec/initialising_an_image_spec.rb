require 'bitmap_editor'
describe 'Bitmap Editor' do
  before :each do
    @input = double :input
    allow(@input).to receive :print
  end

  describe 'executing the initialization command' do
    before :each do
      @output = double(:output).as_null_object
      @editor = BitmapEditor.new @input, @output
    end

    it 'continues to run' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      expect { @editor.run }.not_to raise_error
    end

    it 'generates a white M x N image' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      @editor.run

      expect(@editor.image).to be_white_image(2, 2)
    end

    it 'generates a white image of any size' do
      allow(@input).to receive(:gets).and_return 'I 3 4'

      @editor.run

      expect(@editor.image).to be_white_image(3, 4)
    end

    RSpec::Matchers.define :be_white_image do |width, height|
      match do |image|
        white = 'O'
        white_image = Array.new(height) do
           Array.new(width) { 'O' }
        end

        image == white_image
      end

      failure_message do |actual|
        actual_image = actual.map {|row| row.join}.join("\n")
        message = "Expected a #{width} x #{height} white image but got:\n"
        message << "#{actual.sample.size} x #{actual.size} white image:\n"
        message << actual_image
        message
      end
    end
  end
end
