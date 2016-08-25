require 'spec_helper'
require 'coordinates_helper'
describe 'Coordinates' do
  include CoordinatesHelper

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
