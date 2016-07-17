require 'coordinates'
describe 'Coordinates' do
  include Coordinates
  describe '#within_bounds?' do
    context 'when the x-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = Coordinates::Point.new(x: 0, y: 5)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the x-coordinates is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = Coordinates::Point.new(x: 251, y: 5)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the y-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = Coordinates::Point.new(x: 10, y: 0)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the y-coordinate is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = Coordinates::Point.new(x: 10, y: 251)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the x and y-coordinates are confined in the space' do
      it 'confirms the co-ordinate as being within bounds' do
        point = Coordinates::Point.new(x: 10, y: 10)
        
        expect(point).to be_within_bounds
      end
    end
  end
end
