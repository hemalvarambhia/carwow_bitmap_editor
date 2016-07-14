require 'commands'
describe 'Bitmap Editor' do
  describe "displaying the image on the canvas" do
    before :each do
      @output = double :output
      @canvas = double(:canvas)
      @display_image = Commands::DisplayImage.new(@output, @canvas)
    end

    it 'displays any image on the canvas' do
      expect(@output).to receive(:puts).with(@canvas)

      @display_image.run []
    end
  end
end
