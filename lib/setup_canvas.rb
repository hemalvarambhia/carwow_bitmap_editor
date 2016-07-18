module Commands
  class SetupCanvas
    USAGE =
        "I - set up a canvas
       M - width (must be between 1 and 250)
       N - height (must be between 1 and 250)
      "
    def initialize(canvas, help)
      @canvas = canvas
      @help = help
    end

    def run args
      if invalid?(args)
        @help.run
      else
        @canvas.blank(width: args.first.to_i, height: args[1].to_i)
      end
    end

    private

    def invalid? args
      width = args.first.to_i
      height = args[1].to_i
      args.size < 2 or
          !width.between?(1, 250) or !height.between?(1, 250)
    end
  end
end