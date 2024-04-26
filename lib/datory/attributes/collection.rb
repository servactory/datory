# frozen_string_literal: true

module Datory
  module Attributes
    class Collection
      extend Forwardable
      def_delegators :@collection, :<<, :each, :map, :filter, :to_h, :merge

      def initialize(collection = Set.new)
        @collection = collection
      end

      def names
        map(&:name)
      end

      def internal_names
        map { |attribute| attribute.options.fetch(:to, attribute.name) }
      end

      def include_exist?
        @include_exist ||= filter do |attribute| # rubocop:disable Performance/Count
          attribute.options.fetch(:include, attribute.options.fetch(:from)) <= Datory::Base
        end.size.positive?
      end
    end
  end
end
