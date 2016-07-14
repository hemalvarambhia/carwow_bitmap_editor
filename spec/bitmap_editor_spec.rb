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

  it "supports a 'paint pixel' command" do
    paint_pixel = double :paint_pixel
    expect(paint_pixel).to receive(:run).with(["1", "2", 'Z'])
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'L 1 2 Z'
    editor = BitmapEditor.new(
        input,
        { 'L' => paint_pixel }
    )

    editor.run
  end

  it "supports a 'paint horizontal line' command" do
    draw_horizontal_line = double :draw_horizontal_line
    expect(draw_horizontal_line).to receive(:run).with(['3', '5', '2', 'Z'])
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'H 3 5 2 Z'
    editor = BitmapEditor.new(
        input,
        { 'H' => draw_horizontal_line }
    )

    editor.run
  end

  it "supports a 'paint vertical line' command" do
    draw_vertical_line = double :draw_vertical_line
    expect(draw_vertical_line).to receive(:run).with(['2', '3', '6', 'W'])
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'V 2 3 6 W'
    editor = BitmapEditor.new(
        input,
        { 'V' => draw_vertical_line }
    )

    editor.run
  end

  it "supports an 'exit editor' command" do
    exit_editor = double :exit_editor
    expect(exit_editor).to receive(:run)
    input = double(:input, print: nil)
    allow(input).to receive(:gets).and_return 'X'
    editor = BitmapEditor.new(
        input,
        { 'X' => exit_editor }
    )

    editor.run
  end
end