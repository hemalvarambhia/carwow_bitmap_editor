module Commands
  class DisplayCanvas
    def initialize(output, canvas)
      @output = output
      @canvas = canvas
    end

    def run *args
      @output.puts @canvas
    end
  end
end
