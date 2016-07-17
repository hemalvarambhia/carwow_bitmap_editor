module Coordinates
  def within_bounds?(row, column)
    column.between?(1, 250) and row.between?(1, 250)
  end 
end
