# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute
      attr_reader :name, :options

      def initialize(name, **options)
        @name = name
        @options = options
      end
    end
  end
end
