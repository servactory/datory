# frozen_string_literal: true

module Datory
  module Attributes
    module Options
      class Base
        attr_reader :name, :type, :consists_of, :min, :max, :format

        def initialize(name:, type:, consists_of:, min:, max:, format:)
          @name = name
          @type = type
          @consists_of = consists_of
          @min = min
          @max = max
          @format = format
        end

        def info
          {
            name:,
            type:,
            min:,
            max:,
            consists_of:,
            format:
          }
        end
      end
    end
  end
end
