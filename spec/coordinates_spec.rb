require 'coordinates_helper'
describe 'Coordinates' do
  include CoordinatesHelper
  describe '#within_bounds?' do
    context 'when the x-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = coordinates(x: 0, y: 5)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the x-coordinates is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = coordinates(x: 251, y: 5)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the y-coordinate is below the minimum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = coordinates(x: 10, y: 0)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the y-coordinate is above the maximum' do
      it 'confirms the co-ordinate as being out of bounds' do
        point = coordinates(x: 10, y: 251)
        
        expect(point).not_to be_within_bounds
      end
    end

    context 'when the x and y-coordinates are confined in the space' do
      it 'confirms the co-ordinate as being within bounds' do
        point = coordinates(x: 10, y: 10)
        
        expect(point).to be_within_bounds
      end
    end
  end

  describe '#==' do
    it 'is reflexive' do
      point = coordinates(x: 5, y: 10)
      
      expect(point).to eq point
    end

    it 'is symmetric' do
      point_1 = coordinates(x: 4, y: 1)
      point_2 = coordinates(x: 4, y: 1)
      
      expect(point_1).to eq point_2
      expect(point_2).to eq point_1
    end

    it 'is transitive' do
      point_1 = coordinates(x: 3, y: 4)
      point_2 = coordinates(x: 3, y: 4)
      point_3 = coordinates(x: 3, y: 4)
      
      expect(point_1).to eq point_2
      expect(point_2).to eq point_3
      expect(point_3).to eq point_1
    end

    context 'given two points' do
      context 'when their x-coordinates are different' do
        it 'confirms that they are not equal' do
          point_1 = coordinates(x: 1, y: 2)
          point_2 = coordinates(x: 2, y: 2)

          expect(point_1).not_to eq point_2
        end
      end

      context 'when their y-coordinates are different' do
        it 'confirms that they are not equal' do
          point_1 = coordinates(x: 3, y: 10)
          point_2 = coordinates(x: 3, y: 1)

          expect(point_1).not_to eq point_2
        end
      end

      context 'when both their x and y-coordinates are the same' do
        it 'confirms that they are equal' do
          point_1 = coordinates(x: 3, y: 4)
          point_2 = coordinates(x: 3, y: 4)

          expect(point_1).to eq point_2
        end
      end
    end
  end
end
