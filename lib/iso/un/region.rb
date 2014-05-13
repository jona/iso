module ISO
  module UN
    class Region < ISO::Region
      DEFINITIONS_FILE = YAML.load_file("#{File.dirname(__FILE__)}/../../../data/un-m49.yml")

      attr_reader :iso_code

      def initialize(code, options={})
        @iso_code = options[:iso_code]
        super(code, options)
      end
      
      def name
        return super if iso_code.nil?
        @options[:name] || I18n.t(iso_code, :scope => i18n_scope)
      end

      def self.identify(full_code)
        code = full_code[/(?<=-)(\d{3})$/]
        if code
          found = DEFINITIONS_FILE[code]
          found['iso_code'] if found
        end
      end
      singleton_class.send(:alias_method, :find, :identify)
    end
  end
end
