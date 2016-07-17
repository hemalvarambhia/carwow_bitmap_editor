require 'commands'
describe 'Painting a horizonal line on the canvas' do
  before :each do
    @canvas = double(:canvas)
    @help = double :help
    @draw_horizontal_line =
      Commands::PaintHorizontalLine.new(@canvas, @help)
  end

  describe 'Correct usage' do
    it 'paints only the horizontal line specified' do
      (1..5).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 2, column: column, colour: 'W'))
      end

      @draw_horizontal_line.run  [1, 5, 2, 'W']
    end

    it 'paints a horizontal line anywhere' do
      (1..2).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 3, column: column, colour: 'W'))
      end

      @draw_horizontal_line.run [1, 2, 3, 'W']
    end

    it 'paints a horizontal line anywhere any colour' do
      (1..2).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 3, column: column, colour: 'Z'))
      end

      @draw_horizontal_line.run [1, 2, 3, 'Z']
    end

    it 'paints a horizontal line from right to left' do
      (1..2).each do |column|
        expect(@canvas).to(
          receive(:paint).with(row: 3, column: column, colour: 'Z'))
      end

      @draw_horizontal_line.run [2, 1, 3, 'Z']
    end

    context 'when it receives extra arguments' do
      it 'ignores them' do
        (4..5).each do |column|
          expect(@canvas).to(
            receive(:paint).with(row: 1, column: column, colour: 'Y'))
          end

        @draw_horizontal_line.run [4, 5, 1, 'Y', 'X']
      end
    end
  end

  describe 'Incorrect usage' do
    before :each do
      allow(@canvas).to receive :paint
    end
    
    context 'when there are too few args' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @draw_horizontal_line.run [1, 2, 3]
      end
    end
  end
end
