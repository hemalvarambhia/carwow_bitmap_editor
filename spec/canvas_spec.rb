require 'bitmap_editor'
describe 'A Canvas' do
  before :each do
    @canvas = BitmapEditor::Canvas.new
  end

  describe '#blank' do
    it 'creates a blank canvas with the specified dimensions' do
      image = @canvas.blank(width: 3 ,height: 3)

      expect(image).to be_width(3).and be_height(3).and be_white
    end

    it 'creates a blank canvas of any specified dimensions' do
      image = @canvas.blank(width: 5 ,height: 4)

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
      @canvas.blank(width: 4, height: 2)

      expect(@canvas.to_s).to eq "OOOO\nOOOO"
    end
  end

  describe '#paint' do
    before :each do
      @canvas.blank(width: 2, height: 2)
    end

    it 'paints the given pixel a colour' do
      @canvas.paint(row: 0, column: 1, colour: 'H')

      expect(@canvas.image[0][1]).to eq 'H'
    end

    it 'paints any pixel a colour' do
      @canvas.paint(row: 1, column: 1, colour: 'H')  
   
      expect(@canvas.image[1][1]).to eq 'H'
    end

    it 'paints any pixel any colour' do
      @canvas.paint(row: 1, column: 0, colour: 'X')       

      expect(@canvas.image[1][0]).to eq 'X'
    end

    it 'leaves all other pixels white' do
      @canvas.paint(row: 1, column: 0, colour: 'X')

      image = @canvas.image
      untouched = [
        image[0][0], image[0][1], image[1][1]
      ]
      expect(untouched).to all eq 'O'
    end
  end
end
