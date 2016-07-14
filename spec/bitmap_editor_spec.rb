require 'bitmap_editor'
describe 'Bitmap Editor' do
  it 'supports a set up canvas command' do
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
end