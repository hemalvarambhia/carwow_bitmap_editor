require 'coordinates'
describe 'Coordinates' do
  include Coordinates
  describe '#within_bounds?' do
    context 'when the x-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        x = 0
        y = 5
        expect(within_bounds?(y, x)).to eq false
      end
    end

    context 'when the x-coordinates is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        x = 251
        y = 5
        expect(within_bounds?(y, x)).to eq false
      end
    end

    context 'when the y-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        x = 10
        y = 0
        expect(within_bounds?(y, x)).to eq false
      end
    end

    context 'when the y-coordinate is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        x = 10
        y = 251
        expect(within_bounds?(y, x)).to eq false
      end
    end

    context 'when the x and y-coordinates are confined in the space' do
      it 'confirms the co-ordinate as being within bounds' do
        x = 10
        y = 10
        expect(within_bounds?(y, x)).to eq true
      end
    end
  end
end
