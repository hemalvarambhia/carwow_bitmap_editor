module Commands
  class SetupCanvas
    USAGE =
        "I - set up a canvas
       M - width (must be between 1 and 250)
       N - height (must be between 1 and 250)
      "
    def initialize canvas
      @canvas = canvas
    end

    def run args
      @canvas.blank(width: args.first.to_i, height: args[1].to_i)
    end
  end
end