module ISO
  class Tag
    attr_reader :language, :regions, :code, :original

    def initialize(code)
      language = ISO::Language.convert_639_1_to_639_3 code.scan(/^[A-Za-z]{1,}/).first
      @original = code
      @code     = language
      @language = Language.identify(language)
      @regions   = Region.identify(@original) || UN::Region.identify(@original)
    end

    def normalize
      self.language ? (self.language[:alpha2] ? self.language[:alpha2] : self.language[:code]) : self.original
    end

    def name
      self.language ? (self.regions.empty? ? self.language[:name] : "#{self.language[:name]}-#{self.regions.join('-').upcase}") : self.original
    end

    def language_tag
      self.regions.empty? ? self.normalize : "#{self.normalize}-#{self.regions.join('-')}"
    end

    def direction
      self.language ? (self.language[:direction] ? self.language[:direction] : "ltr") : "ltr"
    end

  end
end
