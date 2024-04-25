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

      def internal_names
        map { |attribute| attribute.options.fetch(:to, attribute.name) }
      end
    end
  end
end
