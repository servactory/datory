# frozen_string_literal: true

module Datory
  module Attributes
    module Options
      class From < Base
        def initialize(name:, type:, consists_of:, min:, max:, format:)
          format = format.fetch(:from, nil) if format.is_a?(Hash)

          super(name: name, type: type, consists_of: consists_of, min: min, max: max, format: format)
        end
      end
    end
  end
end
