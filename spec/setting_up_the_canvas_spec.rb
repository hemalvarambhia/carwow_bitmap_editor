require 'commands'
describe 'Setting up the canvas' do
  before :each do
    @canvas = double(:canvas)
    @help = double :help
    @set_up_canvas = Commands::SetupCanvas.new @canvas, @help
  end

  it 'creates a white M x N canvas' do
    expect(@canvas).to receive(:blank).with(width: 2, height: 2)

    @set_up_canvas.run [2, 2]
  end

  it 'generates a white canvas of any size' do
    expect(@canvas).to receive(:blank).with(width: 3, height: 4)

    @set_up_canvas.run [3, 4]
  end

  context 'when extra arguments are given' do
    it 'ignores them' do
      expect(@canvas).to receive(:blank).with(width: 2, height: 10)

      @set_up_canvas.run [2, 10, 'A']
    end
  end

  describe 'incorrect usage' do
    context 'when all dimensions are not specified' do
      it 'demonstrates usage' do
        expect(@help).to receive :run
        
        @set_up_canvas.run [2]
      end
    end

    context 'when the width is less than the allowed minimum' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @set_up_canvas.run [ -5, 1 ]
      end
    end

    context 'when the width is over the allowed maximum' do
      it 'demonstrates usage' do
        expect(@help).to receive :run

        @set_up_canvas.run [251, 1]
      end
    end
  end
end

