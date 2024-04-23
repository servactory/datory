# frozen_string_literal: true

module Datory
  module Utils
    module_function

    TRANSFORMATIONS = {
      Date => ->(value) { Date.parse(value) },
      Time => ->(value) { Time.parse(value) },
      DateTime => ->(value) { DateTime.parse(value) },
      Symbol => ->(value) { value.to_sym },
      String => ->(value) { value.to_s },
      Integer => ->(value) { value.to_i },
      Float => ->(value) { value.to_f }
    }.freeze

    private_constant :TRANSFORMATIONS

    def transform_value_with(value, type)
      TRANSFORMATIONS.fetch(type, ->(v) { v }).call(value)
    end
  end
end
