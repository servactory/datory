# frozen_string_literal: true

module Datory
  module Attributes
    module Options
      class To < Base
        attr_reader :required, :default, :include_class

        def initialize(name:, type:, required:, default:, consists_of:, min:, max:, format:, include_class:)
          @required = required
          @default = default
          @include_class = include_class

          format = format.fetch(:to, nil) if format.is_a?(Hash)

          super(name: name, type: type, consists_of: consists_of, min: min, max: max, format: format)
        end

        def info
          super.merge(
            required: required,
            default: default,
            include: include_class
          )
        end
      end
    end
  end
end
