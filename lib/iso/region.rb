class ISO::Region < ISO::Subtag
  DEFINITIONS_FILE   = "#{File.dirname(__FILE__)}/../../data/iso-3166-1.yml"

  def self.identify(full_code)
    # Temporarily going against standard to allow lowercase matching of region codes
    code = full_code[/(?<=[-_])?([A-Za-z]{2})$/]
    code if code && YAML.load_file(DEFINITIONS_FILE).keys.include?(code.upcase)
  end
  singleton_class.send(:alias_method, :find, :identify)

private

  def i18n_scope
    super << ".regions"
  end
end
