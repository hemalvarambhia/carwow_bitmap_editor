require 'bitmap_editor'
describe 'A Canvas' do
  describe '#blank' do
    it 'creates a blank canvas with the specified dimensions' do
      canvas = BitmapEditor::Canvas.new
      image = canvas.blank(width: 3 ,height: 3)

      expect(image).to be_width(3).and be_height(3).and be_white
    end

    it 'creates a blank canvas of any specified dimensions' do
      canvas = BitmapEditor::Canvas.new
      image = canvas.blank(width: 5 ,height: 4)

      expect(image).to be_width(5).and be_height(4).and be_white
    end

    RSpec::Matchers.define :be_width do |expected_width|
      match do |image|
        image.all? { |row| row.size == expected_width }
      end
    end
    
    RSpec::Matchers.define :be_height  do |expected_height|
      match do |image|
        image.size == expected_height
      end
    end

    RSpec::Matchers.define :be_white do
      match do |image|
        white = Array.new(image.sample.size) {'O'}
        image.all? { |row| row == white }
      end
    end
  end

  describe '#to_s' do
    it 'renders the pixels as a string' do
      canvas = BitmapEditor::Canvas.new
      canvas.blank(width: 4, height: 2)

      expect(canvas.to_s).to eq "OOOO\nOOOO"
    end
  end
end
