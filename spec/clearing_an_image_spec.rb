require 'bitmap_editor'

describe 'Bitmap Editor' do
  describe 'executing the clear command' do
    it 'colours all pixels white' do
      input = double(:input, print: nil)
      allow(input).to receive(:gets).and_return 'I 4 3', 'V 1 1 3 W', 'C'
      editor = BitmapEditor.new(input, nil)

      3.times { editor.run }
      image = editor.image
      expect(editor.image).to be_white_image(4, 3)
    end

    RSpec::Matchers.define :be_white_image do |width, height|
      match do |image|
        dimensions = { width: width, height: height }
        image ==
          BitmapEditor::BitmapImage.white(dimensions).image
      end

      failure_message do |actual|
        actual_image = actual.map {|row| row.join}.join("\n")
        message = "Expected a #{width} x #{height} white image but got:\n"
        message << "#{actual.sample.size} x #{actual.size} image:\n"
        message << actual_image
        message
      end
    end
  end
end
