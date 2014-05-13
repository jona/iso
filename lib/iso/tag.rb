module ISO
  class Tag
    attr_reader :language, :regions, :code

    def initialize(code)
      language = ISO::Language.convert_639_1_to_639_3 code.scan(/^[A-Za-z]{1,}/).first
      @code     = language
      @language = Language.identify(language)
      @regions   = Region.identify(code) || UN::Region.identify(code)
    end
  end
end
