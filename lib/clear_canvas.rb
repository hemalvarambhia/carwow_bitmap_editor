module Commands
  class ClearCanvas
    def initialize canvas
      @canvas = canvas
    end

    def run *args
      @canvas.clear
    end
  end
end
