class ISO::Language < ISO::Subtag
  DEFINITIONS_FILE          = "#{File.dirname(__FILE__)}/../../data/iso-639-3-639-1.yml"
  ALL_LANGUAGES             = "#{File.dirname(__FILE__)}/../../languages.yml"
  MAPPING_FILE              = "#{File.dirname(__FILE__)}/../../data/iso-639-1-639-3-mapping.yml"
  DEFAULT_PLURAL_RULE_NAMES = %w(one other)
  DEFAULT_DIRECTION         = 'ltr'
  DEFAULT_CODE              = 'en'
  PLURAL_RULE_NAMES         = %w(zero one two few many other)

  attr_reader :plural_rule_names, :direction

  def initialize(code, options={})
    @plural_rule_names = options[:plural_rule_names] || DEFAULT_PLURAL_RULE_NAMES
    @direction         = options[:direction]         || DEFAULT_DIRECTION
    super(code, options)
  end

  def self.all_tags

    @all_tags ||= YAML.load_file(ISO::Language::ALL_LANGUAGES).map do |lang|
      {name: lang[:name], code: lang[:iso_639_3]}
    end
  end

  def self.convert_639_1_to_639_3(code)
    YAML.load_file(MAPPING_FILE)[code] || code
  end

  def self.identify(full_code, response={})
    code = full_code.split('-').first
    YAML.load_file(DEFINITIONS_FILE)[code.downcase].try(:each) do |key, value|
      response.merge! key.to_sym => value
    end
    response.merge!(code: code).has_key?(:name) ? response : nil
  end

  singleton_class.send(:alias_method, :find, :identify)

private
  def i18n_scope
    super << ".languages"
  end
end
