require 'active_support/inflector'
require 'active_support/core_ext/string/inflections'

module DecentExposure
  class Inflector
    attr_reader :string, :original, :model
    alias name string

    def initialize(name, model = nil)
      @original = name
      @string = name.to_s
      @model = model || name
    end

    def constant(context=Object)
      case model
      when Module, Class
        model
      else
        context.const_get model.to_s.classify
      end
    end

    def parameter
      singular + "_id"
    end

    def singular
      @singular ||= string.singularize.parameterize
    end

    def plural
      string.pluralize
    end
    alias collection plural

    def plural?
      plural == string && !uncountable?
    end

    def uncountable?
      plural == singular
    end
  end
end
