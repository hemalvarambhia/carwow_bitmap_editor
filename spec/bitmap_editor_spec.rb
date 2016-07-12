require 'bitmap_editor'
describe 'Editing a Bitmap' do
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
     	white_image = Array.new(height) do
           Array.new(width) { 'O' } 
        end

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

    context 'when there is no image' do
      it 'displays nothing' do
        allow(@input).to receive(:gets).and_return 'S'
      	expect(@output).to receive(:puts).with ""

        @editor.run
      end
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
    before :each do
      @input = double :input
      @output = double :output
      @editor = BitmapEditor.new(@input, @output)
    end

    context 'when there is no image' do
      it 'does not assign a colour' do
        allow(@input).to receive(:gets).and_return 'L 4 4'

        image = @editor.image
        expect(image).to be_empty
      end
    end

    it 'assigns a pixel the colour specified' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'L 2 3 A'

      2.times { @editor.run }
      
      image = @editor.image
      expect(image[2][1]).to eq 'A'
    end

    it 'assigns any pixel any colour' do
      allow(@input).to receive(:gets).and_return 'I 5 6', 'L 4 4 B'

      2.times { @editor.run }

      image = @editor.image
      expect(image[3][3]).to eq 'B'
    end

    it 'leaves all other pixels untouched' do
      allow(@input).to receive(:gets).and_return 'I 2 2', 'L 1 1 B'

      2.times { @editor.run }

      image = @editor.image
      unaffected = [ image[0][1], image[1][0], image[1][1] ]
      expect(unaffected).to all eq 'O'
    end
  end
end
