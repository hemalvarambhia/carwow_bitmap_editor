describe 'Editing a Bitmap' do
  class BitmapEditor
    attr_reader :image
    def initialize(input, output)
      @input = input
      @output = output
      @image = []
    end

    def run
      command = @input.gets.strip
      type, args = parse command
      initialize_image(
        width: args.first.to_i, height: args.last.to_i) if type == 'I'

      @image[2][1] = 'A' if type == 'L' 

      @output.puts image_as_string if type == 'S'
 
      exit if type == 'X'
    end

    private

    def parse command 
      type, *args = command.split ' '

      return type, args
    end

    def initialize_image(dimensions)
      @image = white_image(dimensions[:width], dimensions[:height])
    end

    def white_image(width, height)
      white_rows = Array.new(width) { 'O' }
      white_image = Array.new(height) { white_rows }

      white_image
    end

    def image_as_string
      @image.map { |row| row.join }.join("\n")
    end
  end

  context 'when an exit command is received' do
    before :each do
      @input = double :input
      @output = double(:output).as_null_object
      @editor = BitmapEditor.new(@input, @output)
    end
    
    it 'exits' do
      allow(@input).to receive(:gets).and_return 'X'

      expect { @editor.run }.to raise_error SystemExit
    end

    context 'when the exit command contains a new line' do
      it 'exits' do
        allow(@input).to receive(:gets).and_return "X\n"
        
        expect { @editor.run }.to raise_error SystemExit
      end
    end
  end

  context 'when an initialize command is received' do
    before :each do
      @input = double :input
      @output = double(:output).as_null_object
      @editor = BitmapEditor.new @input, @output
    end

    it 'continues to run' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      expect { @editor.run }.not_to raise_error
    end

    it 'generates a white M x N image' do
      allow(@input).to receive(:gets).and_return 'I 2 2'

      @editor.run

      expect(@editor.image).to be_white_image(2, 2)
    end

    it 'generates a white image of any size' do
      allow(@input).to receive(:gets).and_return 'I 3 4'

      @editor.run

      expect(@editor.image).to be_white_image(3, 4)
    end

    RSpec::Matchers.define :be_white_image do |width, height|
      match do |image|
        white = 'O' 
        columns = Array.new(width) { white }
     	white_image = Array.new(height) { columns }
        image == white_image
      end

      failure_message do |actual|
        actual_image = actual.map {|row| row.join}.join("\n")
        message = "Expected a #{width} x #{height} white image but got:\n"
        message << "#{actual.sample.size} x #{actual.size} white image:\n"
        message << actual_image
        message
      end
    end
  end

  context "when a 'show contents' command is received" do
    before :each do
      @input = double :input
      @output = double :output
      @editor = BitmapEditor.new(@input, @output)
    end

    it 'continues to run' do
      allow(@output).to receive :puts
      allow(@input).to receive(:gets).and_return 'S'

      expect { @editor.run }.not_to raise_error
    end

    it 'displays the contents of the image' do
      allow(@input).to receive(:gets).and_return 'I 3 2', 'S'
      expect(@output).to receive(:puts).with("OOO\nOOO")

      2.times { @editor.run }
    end 

    it 'displays the contents of any image' do
      allow(@input).to receive(:gets).and_return 'I 4 4', 'S'
      expect(@output).to receive(:puts).with("OOOO\nOOOO\nOOOO\nOOOO")
    
      2.times { @editor.run }
    end
  end

  context "when a 'colour pixel' command is received" do
    it 'colours the pixel the color specified' do
      input = double :input
      io_output = double :output
      allow(input).to receive(:gets).and_return 'I 5 6', 'L 2 3 A'
      editor = BitmapEditor.new(input, io_output)

      2.times { editor.run }
      
      image = editor.image
      expect(image[2][1]).to eq 'A'
    end
  end
end
