# frozen_string_literal: true

module Datory
  module Attributes
    module Options
      class To < Base
        attr_reader :required, :include_class

        def initialize(name:, type:, required:, consists_of:, min:, max:, include_class:)
          @required = required
          @include_class = include_class

          super(name: name, type: type, consists_of: consists_of, min: min, max: max)
        end

        def info
          super.merge(
            required: required,
            include: include_class
          )
        end
      end
    end
  end
end
