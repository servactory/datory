# frozen_string_literal: true

module Datory
  module Info
    class Result
      attr_reader :attributes

      def initialize(attributes:)
        @attributes = attributes
      end
    end
  end
end
