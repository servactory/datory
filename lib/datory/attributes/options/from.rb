# frozen_string_literal: true

module Datory
  module Attributes
    module Options
      class From < Base
        def initialize(name:, type:, consists_of:, min:, max:, format:)
          format = format.fetch(:from, nil) if format.is_a?(Hash)

          super
        end
      end
    end
  end
end
