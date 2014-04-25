class ISO::Language < ISO::Subtag
  DEFINITIONS_FILE          = "#{File.dirname(__FILE__)}/../../data/iso-639-3.yml"
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
    @all_tags ||= YAML.load_file(DEFINITIONS_FILE).map do |code, options|
      {code => options["name"]}
    end
  end

  def self.convert_639_1_to_639_3(code)
    YAML.load_file(MAPPING_FILE)[code] || code
  end

  def self.identify(full_code)
    segments = full_code.split('-')
    find convert_639_1_to_639_3 segments.first
  end

private
  def i18n_scope
    super << ".languages"
  end
end
