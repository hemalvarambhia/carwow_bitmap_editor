describe 'Editing a Bitmap' do
  class BitmapEditor
    attr_reader :image
    def initialize(input, output)
      @input = input
      @output = output
      @image = []
    end

    def run
      command = @input.gets
      if command.split(' ')[0] == 'I'
        width = command.split(' ')[1].to_i
        height = command.split(' ')[2].to_i
        @image = white_image(width, height)
      end
      to_string = @image.map { |row| row.join }.join("\n")
      @output.puts to_string if command.split[0] == 'S'
 
      exit if command == 'X'
    end

    private

    def white_image(width, height)
      white_rows = Array.new(width) { 'O' }
      white_image = Array.new(height) { white_rows }

      white_image
    end
  end

  context 'when an exit command is received' do
    it 'exits' do
      input = double(:input)
      output = double(:output).as_null_object
      allow(input).to receive(:gets).and_return 'X'
      editor = BitmapEditor.new input, output

      expect { editor.run }.to raise_error SystemExit
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
end