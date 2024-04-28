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
          include_class = attribute.options.fetch(:include, nil)

          next false if include_class.nil?

          if [Set, Array].include?(include_class)
            include_class.any? { |item| item <= Datory::Base }
          else
            include_class <= Datory::Base
          end
        end.size.positive?
      end
    end
  end
end
