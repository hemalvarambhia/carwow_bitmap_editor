require 'bitmap_editor'
describe 'A Canvas' do
  describe '#blank' do
    it 'creates a blank canvas with the specified dimensions' do
      canvas = BitmapEditor::Canvas.new
      image = canvas.blank(width: 3 ,height: 3)
      expect(image).to be_width(3).and be_height(3).and be_white
    end

    RSpec::Matchers.define :be_width do |expected_width|
      match do |image|
        image.sample.size == expected_width
      end
    end
    
    RSpec::Matchers.define :be_height  do |expected_height|
      match do |image|
        @expected_height = expected_height
      end
    end

    RSpec::Matchers.define :be_white do
      match do |image|
        white = Array.new(image.sample.size) {'O'}
        image.all? { |row| row == white }
      end
    end
  end
end
