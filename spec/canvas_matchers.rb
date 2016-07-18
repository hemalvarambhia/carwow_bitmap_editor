module CanvasMatchers
  RSpec::Matchers.define :be_width do |expected_width|
    match do |canvas|
      image = canvas.image
      image.all? { |row| row.size == expected_width }
    end
  end

  RSpec::Matchers.define :be_height  do |expected_height|
    match do |canvas|
      image = canvas.image
      image.size == expected_height
    end
  end

  RSpec::Matchers.define :be_painted do |colour|
    match do |canvas|
      colour_at_point = canvas.image[@point.y - 1][@point.x - 1]
      colour_at_point == colour
    end

    chain :at do |point|
      @point = point
    end

    failure_message do |actual|
      image = actual.image
      actual_colour = image[@point.y - 1][@point.x - 1]
      message = "Expected colour at (#{@point.x}, #{@point.y}) to "
      message << "be #{colour} but was #{actual_colour}"
      message
    end
  end
end