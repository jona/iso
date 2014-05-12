module ISO
  class Tag
    attr_reader :language, :region, :code

    def initialize(code)
      @code     = code
      @language = Language.identify(code)
      @region   = Region.identify(code) || UN::Region.identify(code)
    end
  end
end
