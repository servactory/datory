# frozen_string_literal: true

module Datory
  module Utils
    module_function

    D_TRANSFORMATIONS = {
      Symbol => ->(value) { value.to_sym },
      String => ->(value) { value.to_s },
      Integer => ->(value) { value.to_i },
      Float => ->(value) { value.to_f },
      Date => ->(value) { Date.parse(value) },
      Time => ->(value) { Time.parse(value) },
      DateTime => ->(value) { DateTime.parse(value) },
      ActiveSupport::Duration => ->(value) { ActiveSupport::Duration.parse(value) }
    }.freeze

    private_constant :D_TRANSFORMATIONS

    S_TRANSFORMATIONS = {
      Symbol => ->(value, _type) { value.to_sym },
      String => ->(value, _type) { value.to_s },
      Integer => ->(value, _type) { value.to_i },
      Float => ->(value, _type) { value.to_f },
      Date => ->(value, _type) { value.to_s },
      Time => ->(value, _type) { value.to_s },
      DateTime => ->(value, _type) { value.to_s },
      ActiveSupport::Duration => ->(value, _type) { value.iso8601 }
    }.freeze

    private_constant :S_TRANSFORMATIONS

    def transform_value_with(format, value, type)
      if format == :d
        D_TRANSFORMATIONS.fetch(type, ->(v) { v }).call(value)
      else
        S_TRANSFORMATIONS.fetch(value.class, ->(v, _type) { v }).call(value, type)
      end
    end
  end
end
