# frozen_string_literal: true

module Datory
  module Setters
    class Setter
      attr_reader :name, :block

      def initialize(name, block)
        @name = name
        @block = block
      end
    end
  end
end
