require 'commands'
describe 'Drawing a vertical line on the canvas' do
  before :each do
    @canvas = double(:canvas)
    @draw_vertical_line = Commands::DrawVerticalLine.new(@canvas)
  end

  it 'draws a vertical line on the specified part' do
    (3..6).each do |row|
      expect(@canvas).to(
          receive(:paint).with(column: 2, row: row, colour: 'W'))
    end

    @draw_vertical_line.run [2, 3, 6, 'W']
  end

  it 'draws a vertical line anywhere' do
    (1..3).each do |row|
      expect(@canvas).to(
          receive(:paint).with(column: 5, row: row, colour: 'W'))
    end

    @draw_vertical_line.run [5, 1, 3, 'W']
  end

  it 'draws a vertical line anywhere in any colour' do
    (2..4).each do |row|
      expect(@canvas).to(
          receive(:paint).with(column: 4, row: row, colour: 'H'))
    end

    @draw_vertical_line.run [4, 2, 4, 'H']
  end

  it 'is draws from the bottom to the top' do
    (2..4).each do |row|
      expect(@canvas).to(
          receive(:paint).with(column: 4, row: row, colour: 'H'))
    end

    @draw_vertical_line.run [4, 4, 2, 'H']
  end

  context 'when it receives extra parameters' do
    it 'ignores them' do
      (2..3).each do |row|
        expect(@canvas).to(
            receive(:paint).with(column: 1, row: row, colour: 'H'))
      end

      @draw_vertical_line.run [1, 2, 3, 'H', 'N']
    end
  end
end
