# frozen_string_literal: true

module Datory
  module Attributes
    class Collection
      extend Forwardable
      def_delegators :@collection, :<<, :each, :map, :to_h, :merge

      def initialize(collection = Set.new)
        @collection = collection
      end

      def names
        map(&:name)
      end
    end
  end
end
