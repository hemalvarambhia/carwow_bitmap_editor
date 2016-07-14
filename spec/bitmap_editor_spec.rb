require 'bitmap_editor'
describe 'Bitmap Editor' do
  it "supports a 'new canvas' command" do
    blank_canvas_command = double :set_up_canvas
    expect(blank_canvas_command).to receive(:run).with [ "2", "3" ]
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'I 2 3'
    editor = BitmapEditor.new(
        input,
        { 'I' => blank_canvas_command }
    )

    editor.run
  end

  it "supports a 'clear canvas' command" do
    clear_canvas_command = double :clear_canvas
    expect(clear_canvas_command).to receive(:run)
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'C'
    editor = BitmapEditor.new(
        input,
        { 'C' => clear_canvas_command }
    )

    editor.run
  end

  it "supports a 'display image' command" do
    display_image_command = double :display_image
    expect(display_image_command).to receive(:run)
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'S'
    editor = BitmapEditor.new(
        input,
        { 'S' => display_image_command }
    )

    editor.run
  end
end