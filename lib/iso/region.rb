class ISO::Region < ISO::Subtag
  DEFINITIONS_FILE   = YAML.load_file("#{File.dirname(__FILE__)}/../../data/iso-3166-1.yml")

  def self.identify(full_code)
    # Temporarily going against standard to allow lowercase matching of region codes
    matches = full_code.scan /([A-Za-z]{1,})/
    code = []
    if matches
      matches.each_with_index do |m, index|
        next if index == 0
        code.push m.first
      end
    end
    code
  end
  singleton_class.send(:alias_method, :find, :identify)

private

  def i18n_scope
    super << ".regions"
  end
end
